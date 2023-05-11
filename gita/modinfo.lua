
name = "可爱波奇酱"  ---mod名字
description = "阴暗的~~潮湿的~~爬行的~~孤独的————野椎蛇吉他手波奇！！"  --mod描述
author = "asuka" --作者
version = "1.0" -- mod版本 上传mod需要两次的版本不一样

forumthread = ""    --和官方论坛相关，一般不填

api_version = 10    --api版本，现在版本写10就行

dst_compatible = true --是否兼容联机

dont_starve_compatible = false --是否兼容原版
reign_of_giants_compatible = false --是否兼容巨人DLC

all_clients_require_mod = true --所有人都需要mod，true就是

icon_atlas = "modicon.xml" --mod图标
icon = "modicon.tex"

server_filter_tags = {  --服务器标签
"character"
}

--[[  取消注释，在这行前面加个-就行。可选的mod设置，在modmain里面用 GetModConfigData("test_name") 来获取值，data只能是boolean/string/number
configuration_options = {
	{
		name = "test_name",
		label = "一直显示的选项标题",
		hover = "选中时最上面显示的提示",
		options =		
			{
				{description = "选项1", data = true, hover = "提示1"},
				{description = "选项2", data = false, hover = "提示2"},		
			},
		default = true,
	},
}
--]]
