package ${package.Mapper};

import ${package.Entity}.${entity};
import ${superMapperClassPackage};
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
* <p>
    * ${table.comment!} Mapper 接口
    * </p>
*
* @author ${author}
* @since ${date}
*/
<#if kotlin>
    interface ${table.mapperName} : ${superMapperClass}<${entity}>
<#else>
    public interface ${table.mapperName} extends ${superMapperClass}<${entity}> {



    /** 分页查询${cfg.entityName}
    * @param map.page  页码
    * @param map.limit  查几条
    * @param map.${cfg.entityfineName}  前端传进的参数
    * @return 返回统一分页信息
    */
    List<${cfg.entityName}> selectMyPage(@Param("map") Map map);
    Integer countMyPage(@Param("map") Map map);

    }
</#if>
