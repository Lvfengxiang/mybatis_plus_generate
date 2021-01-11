package com.lv.generator;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.exceptions.MybatisPlusException;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.InjectionConfig;
import com.baomidou.mybatisplus.generator.config.*;
import com.baomidou.mybatisplus.generator.config.builder.ConfigBuilder;
import com.baomidou.mybatisplus.generator.config.po.TableField;
import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import com.baomidou.mybatisplus.generator.config.rules.DateType;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;
import freemarker.template.Configuration;
import freemarker.template.Template;

import java.io.File;
import java.io.FileWriter;
import java.io.Writer;
import java.util.*;

/**
 * <p>
 * 代码生成器演示
 * </p>
 */
public class GeneratorJava extends AutoGenerator {
    /**
     * 以下为代码生成器配置
     */
    public static final String MP_GENNERATOR = "吕凤祥";
    public static final String MP_OUT_DIR = "D:\\Generator";
    public static final boolean MP_SWAGGER = true;
    public static final String MP_DATABASE_URL = "jdbc:mysql://127.0.0.1:3306/tea_bus?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Shanghai";
    public static final String MP_DATABASE_NAME = "root";
    public static final String MP_DATABASE_PASS = "";
    public static final String MP_PACKGE = "com.lv";


    /**
     * <p>
     * 读取控制台内容
     * </p>
     */
    public static String scanner(String tip) {
        Scanner scanner = new Scanner(System.in);
        StringBuilder help = new StringBuilder();
        help.append("请输入" + tip + "：");
        System.out.println(help.toString());
        if (scanner.hasNext()) {
            String ipt = scanner.next();
            return ipt;
        }
        throw new MybatisPlusException("请输入正确的" + tip + "！");
    }


    public static void main(String[] args) {

        // 代码生成器
        AutoGenerator mpg = new AutoGenerator();

        // 全局配置
        GlobalConfig gc = new GlobalConfig();
        String projectPath = System.getProperty("user.dir");
        gc.setOutputDir(MP_OUT_DIR);
        gc.setAuthor(MP_GENNERATOR);
        gc.setOpen(true);
        gc.setSwagger2(MP_SWAGGER);
        gc.setDateType(DateType.ONLY_DATE);
        gc.setBaseResultMap(true);
        gc.setBaseColumnList(true);
        gc.setServiceName("%sService");
        //  gc.setSwagger2(true);
        gc.setActiveRecord(true);
        mpg.setGlobalConfig(gc);

        // 数据源配置
        DataSourceConfig dsc = new DataSourceConfig();
        dsc.setUrl(MP_DATABASE_URL);
        // dsc.setSchemaName("public");
        dsc.setDriverName("com.mysql.cj.jdbc.Driver");
        dsc.setUsername(MP_DATABASE_NAME);
        dsc.setPassword(MP_DATABASE_PASS);

        mpg.setDataSource(dsc);

        // 包配置
        PackageConfig pc = new PackageConfig();
        //pc.setModuleName(scanner("模块名"));
        pc.setParent(MP_PACKGE);
        pc.setEntity("commen.bean");
        pc.setService("core.service");
        pc.setServiceImpl("core.serviceimpl");
        pc.setController("api.controller");
        pc.setXml("core.mapper");
        pc.setMapper("core.mapper");
        mpg.setPackageInfo(pc);

        // 自定义配置
        InjectionConfig cfg = new InjectionConfig() {
            @Override
            public void initMap() {
                // to do nothing
                GeneratorJava generatorJava = new GeneratorJava();
                List<TableInfo> list = generatorJava.getAllTableInfoList(mpg.getConfig());
                //循环表
                for (int i = 0; i < list.size(); i++) {
                    TableInfo tableInfo = list.get(i);
                    String entityName = tableInfo.getEntityName();
                    List<TableField> fields = tableInfo.getFields();
                    Map<String, Object> map = new HashMap<>();
                    map.put("entityName", entityName);
                    map.put("entityfineName", StrUtil.lowerFirst(entityName));
                    map.put("fields", fields);
                    this.setMap(map);
                }
            }
        };


        // 如果模板引擎是 velocity
        // String templatePath = "/templates/mapper.xml.vm";

        // 自定义输出配置
        List<FileOutConfig> focList = new ArrayList<>();
        // 自定义配置会被优先输出
/*
		focList.add(new FileOutConfig(templatePath) {
			@Override
			public String outputFile(TableInfo tableInfo) {
				// 自定义输出文件名 ， 如果你 Entity 设置了前后缀、此处注意 xml 的名称会跟着发生变化！！
				return projectPath + "/src/main/resources/mapper/" + pc.getModuleName()
						+ "/" + tableInfo.getEntityName() + "Mapper" + StringPool.DOT_XML;
			}
		});
*/

        cfg.setFileOutConfigList(focList);
        mpg.setCfg(cfg);

        // 配置模板
        TemplateConfig templateConfig = new TemplateConfig();

        //指定自定义模板路径，注意不要带上.ftl/.vm, 会根据使用的模板引擎自动识别
        // 如果模板引擎是 freemarker
        templateConfig.setService("templates/MyEntity.java");
        templateConfig.setService("templates/MyService.java");
        templateConfig.setServiceImpl("templates/MyServiceImpl.java");
        templateConfig.setController("templates/MyController.java");
        templateConfig.setMapper("/templates/MyMapper.java");
        templateConfig.setXml("/templates/MyMapper.xml");
        mpg.setTemplate(templateConfig);

        // 策略配置
        StrategyConfig strategy = new StrategyConfig();
        strategy.setNaming(NamingStrategy.underline_to_camel);
        //	strategy.setSuperEntityClass("com.baomidou.ant.common.BaseEntity");
        //strategy.setEntityLombokModel(true);
        //RestController
        strategy.setRestControllerStyle(false);
        //strategy.setSuperControllerClass("com.baomidou.ant.common.BaseController");
        strategy.setInclude(scanner("表名"));
        //  strategy.setSuperEntityColumns("id");
        strategy.setControllerMappingHyphenStyle(false);
        strategy.setTablePrefix("tr_");
        strategy.setEntityTableFieldAnnotationEnable(true);
        mpg.setStrategy(strategy);
        mpg.setTemplateEngine(new FreemarkerTemplateEngine());
        mpg.execute();

        GenHtml(mpg.getConfig());

    }

    public static void GenHtml(ConfigBuilder plusConfig) {
        GeneratorJava generatorJava = new GeneratorJava();
        List<TableInfo> list = generatorJava.getAllTableInfoList(plusConfig);
        //循环表
        for (int i = 0; i < list.size(); i++) {
            TableInfo tableInfo = list.get(i);
            System.err.println(tableInfo);
            String htmlName = tableInfo.getEntityName();
            List<TableField> tableFieldList = tableInfo.getFields();
            for (int j = 0; j < tableFieldList.size(); j++) {
                System.err.println(tableFieldList.get(j).toString());
            }
            //需要生成的模块
            genFtl(htmlName, tableFieldList, "main");
            genFtl(htmlName, tableFieldList, "add");
            genFtl(htmlName, tableFieldList, "edit");
            genFtl(htmlName, tableFieldList, "show");

        }

    }


    /**
     * @param htmlName       文件名字
     * @param tableFieldList 表字段
     * @param purpose        用途  add edit  show  main
     */
    public static void genFtl(String htmlName, List<TableField> tableFieldList, String purpose) {
        // 第一步：创建一个Configuration对象，直接new一个对象。构造方法的参数就是freemarker对于的版本号。
        Configuration configuration = new Configuration(Configuration.getVersion());
        // 第二步：设置模板文件所在的路径。
        try {
            configuration.setDirectoryForTemplateLoading(FileUtil.file("classpath:templates/"));
            // 第三步：设置模板文件使用的字符集。一般就是utf-8.
            configuration.setDefaultEncoding("utf-8");
            // 第四步：加载一个模板，创建一个模板对象。
            Template template = configuration.getTemplate(purpose + ".ftl");
            // 第五步：创建一个模板使用的数据集，可以是pojo也可以是map。一般是Map。
            Map dataModel = new HashMap();
            dataModel.put("fields", tableFieldList);
            dataModel.put("htmlName", htmlName);
            dataModel.put("htmlFinName", StrUtil.lowerFirst(htmlName));
            // 第六步：创建一个Writer对象，一般创建一FileWriter对象，指定生成的文件名。
            Writer out = new FileWriter(new File(MP_OUT_DIR + StrUtil.toCamelCase(StrUtil.format("_{}_{}.ftl", htmlName, purpose))));
            // 第七步：调用模板对象的process方法输出文件。
            template.process(dataModel, out);
            // 第八步：关闭流。
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}