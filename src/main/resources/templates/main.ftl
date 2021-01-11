<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>表格查询</title>
    ${r'<#assign base=request.contextPath  />'}
    <base id="base" href="${r'${base}'}">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, adminUser-scalable=0">
    <link rel="stylesheet" href="${r'${base}'}/static/win10/component/layui/css/layui.css" media="all">
    <script>
        var base =  ${r'"${base}"'};
    </script>
</head>
<body>
<br>


<div class="demoTable" style="margin-left: 15px;">
    <form class="layui-form " action="">
        <div class="layui-form-item">
            <#list fields as field>
                <#if field.keyFlag==false>
                    <label>${field.comment}</label>
                    <div class="layui-inline">
                        <input class="layui-input" name="${field.propertyName}" id="${field.propertyName}"
                               autocomplete="off">
                    </div>
                </#if>
            </#list>
            <button type="button" class="layui-btn" data-type="reload">
                <i class="layui-icon layui-icon-search">搜索</i>
            </button>
        </div>
    </form>
</div>
<table class="layui-hide" id="test" lay-filter="test"></table>
<script type="text/html" id="toolbarDemo">


    <form class="layui-form " action="">
        <div class="layui-form-item" style="margin-left: 15px;">
            <div class="layui-btn-group">
                <button type="button" class="layui-btn" lay-event="add">增加</button>
                <button type="button" class="layui-btn" lay-event="edit">编辑</button>
                <button type="button" class="layui-btn" lay-event="show">查看</button>
                <button type="button" class="layui-btn" lay-event="del">删除</button>
            </div>
        </div>

    </form>
</script>

<script src="${r'${base}'}/static/win10/component/layui/layui.js?t=1"></script>
<script src="${r'${base}'}/static/win10/js/jquery-1.8.3.min.js?t=1"></script>
<script>
    layui.use(['table'], function () {
        var table = layui.table;
        table.render({
            skin: 'line' //行边框风格
            , even: true //开启隔行背景
            , elem: '#test'
            , url: base + '/admin/${htmlFinName}/find${htmlName}ByPage'
            , toolbar: '#toolbarDemo'
            , cols: [[
                {type: 'radio'},
                <#list fields as field>
                <#if field_has_next>
                {field: '${field.propertyName}', title: '${field.comment}'},
                <#else >
                {field: '${field.propertyName}', title: '${field.comment}'}
                </#if>
                </#list>
            ]]
            , page: true
            , id: 'testReload'
        });
        //搜索
        var $ = layui.$, active = {
            reload: function () {
                //执行重载
                table.reload('testReload', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    , where: {
                <#list fields as field>
                <#if field.keyFlag==false>
                <#if field_has_next>
                ${field.propertyName}:
                $("#${field.propertyName}").val(),
                <#else >
                ${field.propertyName}:
                $("#${field.propertyName}").val()
                </#if>
                </#if>
                </#list>
            }
            },
                'data'
            )
                ;
            }
        };
        $('.demoTable .layui-btn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });


        //头工具栏事件
        table.on('toolbar(test)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id); //获取选中行状态
            var data = checkStatus.data;  //获取选中行数据
            switch (obj.event) {
                case 'add':
                    //请继续补充以下逻辑
                    window.location.href = base + "/admin/${htmlFinName}/add${htmlName}Html"
                    break;
                case 'edit':
                    if (data.length === 0) {
                        layer.alert("请选择一条数据")
                        return;
                    }
                    //请继续补充以下逻辑
                    window.location.href = base + "/admin/${htmlFinName}/edit${htmlName}Html?id=" + data[0].id
                    break;
                case 'show':
                    if (data.length === 0) {
                        layer.alert("请选择一条数据")
                        return;
                    }
                    //请继续补充以下逻辑
                    window.location.href = base + "/admin/${htmlFinName}/show${htmlName}Html?id=" + data[0].id
                    break;
                case 'del':
                    if (data.length === 0) {
                        layer.alert("请选择一条数据")
                        return;
                    }
                    layer.confirm('真的要删除吗?', function (index) {
                        $.ajax({
                            type: "POST",
                            url: base + '/admin/${htmlFinName}/del${htmlName}',
                            data: {"id": data[0].id},
                            success: function (data) {
                                if (data.code === 200) {
                                    layer.msg(data.message)
                                    setTimeout(function () {
                                        window.location.reload();
                                    }, 500)
                                } else {
                                    layer.msg(data.message)
                                }
                            }
                        });
                    });
                    break;
            }
            ;
        });
    })
</script>
</body>
</html>