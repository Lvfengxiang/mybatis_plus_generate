package ${package.Controller};


import org.springframework.web.bind.annotation.RequestMapping;
import ${package.Entity}.result.ResultPage;
<#if restControllerStyle>
    import org.springframework.web.bind.annotation.RestController;
<#else>
    import org.springframework.stereotype.Controller;
    import org.springframework.ui.Model;
    import org.springframework.web.bind.annotation.ResponseBody;

    import ${package.Entity}.${entity};
    import ${package.Entity}.result.ResultPage;
    import ${package.Entity}.model.ApiResultModel;
    import java.util.HashMap;
    import java.util.List;
    import java.util.Map;
</#if>
<#if superControllerClassPackage??>
    import ${superControllerClassPackage};
</#if>

/**
* <p>
    * ${table.comment!} 前端控制器
    * </p>
*
* @author ${author}
* @since ${date}
*/
<#if restControllerStyle>
    @RestController
<#else>
    @Controller
</#if>
@RequestMapping("/admin<#if package.ModuleName??>/${package.ModuleName}</#if>/<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>${table.entityPath}</#if>")
<#if kotlin>
    class ${table.controllerName}<#if superControllerClass??> : ${superControllerClass}()</#if>
<#else>
    <#if superControllerClass??>
        public class ${table.controllerName} extends ${superControllerClass} {
    <#else>
        public class ${table.controllerName} extends BaseController{
    </#if>
    /** 主页面 */
    @RequestMapping("main.html")
    public String main(){
    return  "${cfg.entityName}Main";
    }
    /** 添加页面跳转
    * @return 返回页面
    */
    @RequestMapping(value = "/add${cfg.entityName}Html")
    public String add${cfg.entityName}Html( ){
    return "/${cfg.entityName}Add";
    }
    /** 编辑页面跳转
    * @param  id  前端传进的参数
    * @return 返回页面
    */
    @RequestMapping(value = "/edit${cfg.entityName}Html")
    public String edit${cfg.entityName}Html(Integer id ,Model model ){
    model.addAttribute("${cfg.entityfineName}",${cfg.entityfineName}Service.select${cfg.entityName}ById${cfg.entityName}(id));
    return "/${cfg.entityName}Edit";
    }

    /** 查看页面跳转
    * @param  id  前端传进的参数
    * @return 返回页面
    */
    @RequestMapping(value = "/show${cfg.entityName}Html")
    public String show${cfg.entityName}Html(Integer id ,Model model ){
    model.addAttribute("${cfg.entityfineName}",${cfg.entityfineName}Service.select${cfg.entityName}ById${cfg.entityName}(id));
    return "/${cfg.entityName}Show";
    }


    /** 分页查询${cfg.entityName}
    * @param page  页码
    * @param limit  查几条
    * @param ${cfg.entityfineName}  前端传进的参数
    * @return 返回统一分页信息
    */
    @RequestMapping(value = "/find${cfg.entityName}ByPage")
    @ResponseBody
    public ResultPage find${cfg.entityName}ByPage(Integer page, Integer limit,${cfg.entityName} ${cfg.entityfineName}){
    return ${cfg.entityfineName}Service.find${cfg.entityName}ByPage(page,limit,${cfg.entityfineName});
    }

    /** 添加${cfg.entityName}
    * @param ${cfg.entityfineName}  前端传进的参数
    * @return 返回统一信息
    */
    @RequestMapping(value = "/add${cfg.entityName}")
    @ResponseBody
    public ApiResultModel save${cfg.entityName}(${cfg.entityName} ${cfg.entityfineName}  ){
    return ${cfg.entityfineName}Service.add${cfg.entityName}(${cfg.entityfineName});
    }

    /** 编辑${cfg.entityName}
    * @param ${cfg.entityfineName}  前端传进的参数
    * @return 返回统一信息
    */
    @RequestMapping(value = "/edit${cfg.entityName}")
    @ResponseBody
    public ApiResultModel edit${cfg.entityName}(${cfg.entityName} ${cfg.entityfineName}  ){
    return ${cfg.entityfineName}Service.edit${cfg.entityName}(${cfg.entityfineName});
    }



    /** 删除一条${cfg.entityName}
    * @param id  前端传进的ID
    * @return 返回统一信息
    */
    @RequestMapping(value = "/del${cfg.entityName}")
    @ResponseBody
    public ApiResultModel del${cfg.entityName}( Integer id  ){
    return ${cfg.entityfineName}Service.del${cfg.entityName}(id);
    }


    }
</#if>
