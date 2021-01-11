<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${package.Mapper}.${table.mapperName}">

    <#if enableCache>
        <!-- 开启二级缓存 -->
        <cache type="org.mybatis.caches.ehcache.LoggingEhcache"/>

    </#if>
    <#if baseResultMap>
        <!-- 通用查询映射结果 -->
        <resultMap id="BaseResultMap" type="${package.Entity}.${entity}">
            <#list table.fields as field>
                <#if field.keyFlag><#--生成主键排在第一位-->
                    <id column="${field.name}" property="${field.propertyName}"/>
                </#if>
            </#list>
            <#list table.commonFields as field><#--生成公共字段 -->
                <result column="${field.name}" property="${field.propertyName}"/>
            </#list>
            <#list table.fields as field>
                <#if !field.keyFlag><#--生成普通字段 -->
                    <result column="${field.name}" property="${field.propertyName}"/>
                </#if>
            </#list>
        </resultMap>

    </#if>
    <#if baseColumnList>
        <!-- 通用查询结果列 -->
        <sql id="Base_Column_List">
            <#list table.commonFields as field>
                ${field.name},
            </#list>
            ${table.fieldNames}
        </sql>

    </#if>


    <select id="selectMyPage" resultMap="BaseResultMap">
        select * from ${table.name} where 1=1
        <#list cfg.fields as field>
            <if test="map.${cfg.entityfineName}.${field.propertyName}!=null and map.${cfg.entityfineName}.${field.propertyName}!='' ">
                and ${field.name} like "%${r'${map.'}${cfg.entityfineName}.${field.propertyName}${r'}'}%"
            </if>
        </#list>
        limit ${r'#{map.page}'},${r'#{map.limit}'}
    </select>

    <select id="countMyPage" resultType="int">
        select count(*) from ${table.name} where 1=1
        <#list cfg.fields as field>
            <if test="map.${cfg.entityfineName}.${field.propertyName}!=null and map.${cfg.entityfineName}.${field.propertyName}!='' ">
                and ${field.name} like "%${r'${map.'}${cfg.entityfineName}.${field.propertyName}${r'}'}%"
            </if>
        </#list>
    </select>
</mapper>
