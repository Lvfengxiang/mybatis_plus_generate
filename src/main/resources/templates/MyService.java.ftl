package ${package.Service};

import ${package.Entity}.${entity};
import ${superServiceClassPackage};
import ${package.Entity}.result.ResultPage;
import ${package.Entity}.model.ApiResultModel;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
* <p>
    * ${table.comment!} 服务类
    * </p>
*
* @author ${author}
* @since ${date}
*/
<#if kotlin>
    interface ${table.serviceName} : ${superServiceClass}<${entity}>
<#else>
    public interface ${table.serviceName} extends ${superServiceClass}<${entity}> {

    /** 添加${cfg.entityName}
    * @param ${cfg.entityfineName}  前端传进的参数
    * @return 返回统一信息
    */
    ApiResultModel add${cfg.entityName}(${cfg.entityName} ${cfg.entityfineName}  );

    /** 编辑跳转页面的回显数据${cfg.entityName}
    * @param id  前端传进的参数
    * @return 返回实体类
    */
    ${cfg.entityName} select${cfg.entityName}ById${cfg.entityName}(Integer id );

    /** 编辑${cfg.entityName}
    * @param ${cfg.entityfineName}  前端传进的参数
    * @return 返回统一信息
    */
    ApiResultModel edit${cfg.entityName}(${cfg.entityName} ${cfg.entityfineName}  );


    /** 删除一条${cfg.entityName}
    * @param id  前端传进的ID
    * @return 返回统一信息
    */
    ApiResultModel del${cfg.entityName}( Integer id  );


    /** 分页查询${cfg.entityName}
    * @param page  页码
    * @param limit  查几条
    * @param ${cfg.entityfineName}  前端传进的参数
    * @return 返回统一分页信息
    */
    ResultPage find${cfg.entityName}ByPage(Integer page, Integer limit,${cfg.entityName} ${cfg.entityfineName});
    }
</#if>
