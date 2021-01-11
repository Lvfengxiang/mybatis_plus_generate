<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>添加</title>
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
<form class="layui-form " action="">
    <#list fields as field>
        <#if field.keyFlag==false>
            <div class="layui-form-item">
                <label class="layui-form-label">${field.comment}</label>
                <div class="layui-input-block">
                    <input type="text" id="${field.propertyName}" name="${field.propertyName}" autocomplete="off"
                           placeholder="请输入${field.comment}"
                           class="layui-input">
                </div>
            </div>
        </#if>
    </#list>

    <div align="center">
        <button type="button" class="layui-btn" id="submit">保存</button>
    </div>
</form>

<script src="${r'${base}'}/static/win10/component/layui/layui.js?t=1"></script>
<script src="${r'${base}'}/static/win10/js/jquery-1.8.3.min.js?t=1"></script>
<script>
    layui.use(['form', 'layer'], function () {
        var form = layui.form
            , layer = layui.layer;
        $("#submit").on("click", function () {
            if (check() === false) {
                return;
            }

            var formDate = {
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
            $.ajax({
                type: "POST",
                url: base + "/admin/${htmlFinName}/add${htmlName}",
                data: formDate,
                success: function (data) {
                    layer.msg(data.message)
                    if (data.code === 200) {
                        window.location.href = base + "/admin/${htmlFinName}/main.html"
                    } else {

                    }
                }
            });
        })


        function check() {
            <#list fields as field>
            <#if field.keyFlag==false>
            if ($("#${field.propertyName}").val().length < 1) {
                layer.msg("请输入${field.comment}");
                return false;
            }
            </#if>
            </#list>
        }
    });

</script>
</body>
</html>