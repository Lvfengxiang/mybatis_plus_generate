package ${package.ServiceImpl};
import ${package.Entity}.helper.$;
import ${package.Entity}.${entity};
import ${package.Mapper}.${table.mapperName};
import ${package.Service}.${table.serviceName};
import ${superServiceImplClassPackage};
import ${package.Entity}.result.ResultPage;
import ${package.Entity}.model.ApiResultModel;
import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
* <p>
    * ${table.comment!} 服务实现类
    * </p>
*
* @author ${author}
* @since ${date}
*/
@Service
<#if kotlin>
    open class ${table.serviceImplName} : ${superServiceImplClass}<${table.mapperName}, ${entity}>(), ${table.serviceName} {

    }
<#else>
    public class ${table.serviceImplName} extends ${superServiceImplClass}<${table.mapperName}, ${entity}> implements ${table.serviceName} {
    /** 添加${cfg.entityName}
    * @param ${cfg.entityfineName}  前端传进的参数
    * @return 返回统一信息
    */
    @Override
    public ApiResultModel add${cfg.entityName}(${cfg.entityName} ${cfg.entityfineName}  ) {
    if(this.save(${cfg.entityfineName} )){
    return $.success();
    }else{
    return $.error("添加失败");
    }
    }
    /** 编辑跳转页面的回显数据${cfg.entityName}
    * @param id  前端传进的参数
    * @return 返回实体类
    */
    @Override
    public ${cfg.entityName} select${cfg.entityName}ById${cfg.entityName}(Integer id ){
    return this.getById(id);
    }


    /** 编辑${cfg.entityName}
    * @param ${cfg.entityfineName}  前端传进的参数
    * @return 返回统一信息
    */
    @Override
    public ApiResultModel edit${cfg.entityName}(${cfg.entityName} ${cfg.entityfineName}  ) {
    if(this.updateById(${cfg.entityfineName} )){
    return $.success();
    }else{
    return $.error("编辑失败");
    }
    }
    /** 删除一条${cfg.entityName}
    * @param id  前端传进的ID
    * @return 返回统一信息
    */
    @Override
    public   ApiResultModel del${cfg.entityName}( Integer id  ){
    if(this.removeById(id)){
    return $.success();
    }else{
    return $.error("删除失败");
    }
    }

    /** 分页查询${cfg.entityName}
    * @param page  页码
    * @param limit  查几条
    * @param ${cfg.entityfineName}  前端传进的参数
    * @return 返回统一分页信息
    */
    @Override
    public  ResultPage find${cfg.entityName}ByPage(Integer page, Integer limit,${cfg.entityName} ${cfg.entityfineName}){
    Map
    <String, Object> paramMap = new HashMap<>();
    paramMap.put("page", (page - 1) * limit);
    paramMap.put("limit", limit);
    paramMap.put("${cfg.entityfineName}", ${cfg.entityfineName});
    List<${cfg.entityName}> list = baseMapper.selectMyPage(paramMap);
    Integer count = baseMapper.countMyPage(paramMap);
    ResultPage<${cfg.entityName}> resultPage = new ResultPage<>();
    resultPage.setCode(0);
    resultPage.setCount(count);
    resultPage.setMsg("成功");
    resultPage.setData(list);
    return resultPage;
    }
    }
</#if>
