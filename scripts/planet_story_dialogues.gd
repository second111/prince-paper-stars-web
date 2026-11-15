extends RefCounted


const SPEAKER_BY_SCENE := {
	"pointlighter": "点灯人",
	"rose": "玫瑰",
	"vain": "爱慕虚荣的人",
	"merchant": "商人",
	"earth": "狐狸",
}

const TITLE_BY_SCENE := {
	"pointlighter": "点灯人",
	"rose": "玫瑰",
	"vain": "爱慕虚荣的人",
	"merchant": "商人",
	"earth": "狐狸 · 地球",
}

const COMPLETION_QUOTES := {
	"rose": "“保护不是把彼此隔开。有时候，只是把挡在中间的那层雾擦干净。”",
	"vain": "“掌声停下以后，他还站在原地。镜子里面，也只站着他一个人。”",
	"merchant": "“拥有是一笔记录。照料，才是一段关系。”",
	"earth": "“共同花掉的时间，让一件普通的事物开始指向某个人。”",
}


const POINTLIGHTER_DIALOGUE_NODES := {
	"intro": {
		"speaker": "点灯人",
		"text": "灯亮时，我像在叫醒一颗星；灯灭时，又像替它合上眼睛。\n\n可这颗星转得太快，我连抬头的时间也没有。",
		"choices": [
			{"id": "rest", "label": "你一直点灯，不累吗？歇一会儿吧。", "next": "rest"},
			{"id": "purpose", "label": "这里一个人也没有。这盏灯是点给谁看的呀？", "next": "purpose"},
			{"id": "doubt", "label": "如果这件事本来就是错的，你还要一直做吗？", "next": "doubt"},
			{"label": "如果有一分钟不属于命令，您想把它留给谁？", "next": "core"},
		],
	},
	"rest": {
		"speaker": "点灯人",
		"text": "如果我停下来，这盏灯该由谁来记得？",
		"narration": "他说完，先看了一眼灯，又看了一眼自己始终没有离开的位置。",
		"returns_to_menu": true,
		"choices": [],
	},
	"purpose": {
		"speaker": "点灯人",
		"text": "正因无人，才更该有人记得——这里曾有一颗星醒着。",
		"narration": "他的声音很轻，像是在替整颗星球守夜。",
		"returns_to_menu": true,
		"choices": [],
	},
	"doubt": {
		"speaker": "点灯人",
		"text": "错？命令没有改变。改变的只是这颗星球。\n\n它越转越快，我只能把同一件事做得更快。",
		"choices": [
			{"label": "你是在听命令，还是已经不敢停下来啦？", "next": "afraid"},
			{"label": "星星变快了，你也跟着变快。为什么不换一个办法呢？", "next": "speed"},
			{"label": "这里没有人需要这盏灯，你一直记得它，还有用吗？", "next": "meaning"},
		],
	},
	"afraid": {
		"speaker": "点灯人",
		"text": "停下来以后……我还会是点灯人吗？",
		"narration": "他伸手扶住灯柱，像怕一松开，自己也会被这颗转得太快的星甩出去。",
		"choices": [
			{"label": "一直做同一件事，也不能说明你是谁呀。", "next": "reflection"},
		],
	},
	"speed": {
		"speaker": "点灯人",
		"text": "因为服从不需要思考。",
		"narration": "灯又亮了。他的手没有停，眼神却第一次追不上自己的动作。",
		"choices": [
			{"label": "可是你刚才明明想过了呀。", "next": "reflection"},
		],
	},
	"meaning": {
		"speaker": "点灯人",
		"text": "若不算，我度过的每一分钟又是什么？",
		"narration": "他没有提高声音。四周太快地熄灭又亮起，反而让这句话显得很慢。",
		"choices": [
			{"label": "你做过的事，不用别人点头，也还是你的呀。", "next": "reflection"},
		],
	},
	"core": {
		"speaker": "点灯人",
		"text": "这一分钟……不属于命令？\n\n我好像从来没有这样想过。",
		"choices": [
			{"label": "天亮以前，先做一会儿你自己，好不好？", "next": "core_self"},
			{"label": "先把一直重复的事放一放，好不好？", "next": "core_repeat"},
			{"label": "停下来会害怕也没关系，你不用一直站着。", "next": "core_fear"},
		],
	},
	"core_self": {
		"speaker": "点灯人",
		"text": "做一会儿自己……这个动作，我好像从来没有学过。",
		"narration": "他把手从灯柱上移开，掌心还留着金属被风吹凉的温度。",
		"choices": [
			{"label": "那就先坐下来吧。", "next": "reflection"},
		],
	},
	"core_repeat": {
		"speaker": "点灯人",
		"text": "我以为不停重复，就证明责任还在。",
		"narration": "一分钟又过去了。他第一次没有立刻去追它。",
		"choices": [
			{"label": "灯可以亮着，你也可以坐下来呀。", "next": "reflection"},
		],
	},
	"core_fear": {
		"speaker": "点灯人",
		"text": "可是如果我不再点灯，谁还会知道我曾守过这里？",
		"narration": "他把这句话问得很认真，像一个害怕被从故事里删掉的人。",
		"choices": [
			{"label": "我会记得你。你不用每一分钟都证明给我看。", "next": "reflection"},
		],
	},
	"reflection": {
		"speaker": "点灯人",
		"text": "我总在追赶下一分钟，像只要动作比变化快，就不必承认世界已经变了。",
		"narration": "灯还亮着。他终于抬头看了一眼，但那一眼不再是在检查时间。",
		"choices": [
			{"label": "这一分钟，你想做什么呀？", "next": "ending"},
		],
	},
	"ending": {
		"speaker": "点灯人",
		"text": "我不知道。\n\n我想先把这一分钟，留给这个“不知道”。",
		"narration": "整颗星球仍在飞快地转。可他的肩膀，第一次没有跟着赶路。",
		"choices": [
			{"label": "结束对话", "action": "close"},
		],
	},
}


const ROSE_DIALOGUE_NODES := {
	"intro": {
		"speaker": "玫瑰",
		"text": "你终于回来了。风一直从东边来。\n\n别站那么远。让我看看，你离开以后有没有学会照顾一朵花。",
		"choices": [
			{"id": "wind", "label": "你知道风从哪里来，为什么还说它可怕呀？", "next": "wind"},
			{"id": "dome", "label": "玻璃罩挡住了风，也挡住了月光。它真的不会让你难受吗？", "next": "dome"},
			{"id": "unique", "label": "世界上还有那么多玫瑰。你还觉得自己是唯一的一朵吗？", "next": "unique"},
			{"label": "如果我不先开口，你会不会以为我已经走了？", "next": "core"},
		],
	},
	"wind": {
		"speaker": "玫瑰",
		"text": "因为只要我说害怕，你就会先看我一眼。",
		"narration": "她说这句话时，叶片收得很紧。风其实还没有真的吹过来。",
		"returns_to_menu": true,
		"choices": [],
	},
	"dome": {
		"speaker": "玫瑰",
		"text": "我需要它的时候，它就该在。\n\n我不需要它的时候，你最好也还在。",
		"narration": "她说得像在提要求，目光却停在玻璃罩上那一层薄雾。",
		"returns_to_menu": true,
		"choices": [],
	},
	"unique": {
		"speaker": "玫瑰",
		"text": "如果我和别的花没有不同，你为什么先走到这里？\n\n可你最好不要回答得太快。我还没想好要不要相信。",
		"narration": "她轻轻抬起一片花瓣，像是在等一阵没有来的风替她回答。",
		"returns_to_menu": true,
		"choices": [],
	},
	"core": {
		"speaker": "玫瑰",
		"text": "你总是等我说“别走”，才知道往这边看。\n\n可有时候，我只是没有声音。",
		"choices": [
			{"label": "以后你不用先说害怕，我也会来看看你。", "next": "core_care"},
			{"label": "我会靠近你，也会离开。可我们不能总靠猜来等对方。", "next": "core_leave"},
			{"label": "那我先不猜。就站在这里，陪你一会儿。", "next": "core_here"},
		],
	},
	"core_care": {
		"speaker": "玫瑰",
		"text": "那听起来，比我需要的任何一床毯子都可靠。\n\n可我还是会担心。你不能因为我不说，就当我不会难过。",
		"narration": "她终于把一片叶子放到罩面附近，像是在确认它是否真的挡在中间。",
		"choices": [
			{"label": "至少你不用一直用刺来保护自己了。", "next": "reflection"},
		],
	},
	"core_leave": {
		"speaker": "玫瑰",
		"text": "你总是把话说得太清楚。清楚的话，连生气都不好意思。\n\n我不是分不清风和脚步。我只是怕醒来时，两样都听不见。",
		"narration": "她轻轻别过花冠，像把一句没有说完的话藏回叶片后面。",
		"choices": [
			{"label": "我不是不让你留我，我只是想听你说真话。", "next": "reflection"},
		],
	},
	"core_here": {
		"speaker": "玫瑰",
		"text": "现在就够吗？",
		"choices": [
			{"label": "够我们先待一会儿呀。", "next": "core_here_reply"},
		],
	},
	"core_here_reply": {
		"speaker": "玫瑰",
		"text": "那就一会儿。别把它说成永远，我可不会替你保管那么大的词。",
		"narration": "她说得仍旧骄傲，花冠却悄悄转向了你的方向。",
		"choices": [
			{"label": "我没有答应永远呀。可是这一刻，我没有走。", "next": "reflection"},
		],
	},
	"reflection": {
		"speaker": "玫瑰",
		"text": "我总把想留下的话说成钥匙、月光和风。\n\n好像只要先把错推给别的东西，我就不会显得太需要你。",
		"narration": "她让一片叶子轻轻碰到玻璃罩，又立刻收了回去。",
		"choices": [
			{"label": "你不用永远都不害怕。我只想知道，你什么时候是真的在叫我。", "next": "ending"},
		],
	},
	"ending": {
		"speaker": "玫瑰",
		"text": "那风又来了。这次，我告诉你：我不想一个人待着。\n\n替我擦一擦吧。别把整个罩子拿走，我还想把刺留给自己。",
		"narration": "她安静下来。玻璃罩上的雾，反而比刚才更明显了。",
		"choices": [
			{"label": "结束对话", "action": "begin_rose_wipe"},
		],
	},
}


const VAIN_DIALOGUE_NODES := {
	"intro": {
		"speaker": "爱慕虚荣的人",
		"animation": "look_around_001",
		"text": "你终于来了。别急着走。先站到光里，让我看看你。\n\n刚才我问了镜子一个问题，它又不肯回答。",
		"choices": [
			{"id": "alone", "label": "如果这里没有别人，你还会一直等吗？", "next": "alone"},
			{"id": "mirror", "label": "镜子里的你，和现在等别人夸你的你，是同一个人吗？", "next": "mirror"},
			{"id": "petals", "label": "地上的花瓣为什么不扫掉呀？", "next": "petals"},
			{"label": "如果镜子不肯回答，你希望它看见什么？", "next": "core"},
		],
	},
	"alone": {
		"speaker": "爱慕虚荣的人",
		"animation": "look_around_001",
		"text": "会。只是镜子里没有人替我回答。",
		"narration": "他把帽檐抬高了一点，像这样就能让沉默更快结束。",
		"returns_to_menu": true,
		"choices": [],
	},
	"mirror": {
		"speaker": "爱慕虚荣的人",
		"animation": "agree_001",
		"text": "我希望是。\n\n镜子总是显得比我更从容。它不需要等谁开口。",
		"narration": "镜中的倒影没有动，现实中的他却又整理了一次领结。",
		"returns_to_menu": true,
		"choices": [],
	},
	"petals": {
		"speaker": "爱慕虚荣的人",
		"animation": "look_around_001",
		"text": "因为它们至少还留在这里。\n\n离开的花，什么都不会说。",
		"narration": "他用鞋尖碰了碰最近的一片花瓣，又很快把脚收了回去。",
		"returns_to_menu": true,
		"choices": [],
	},
	"core": {
		"speaker": "爱慕虚荣的人",
		"animation": "agree_001",
		"text": "看见我。\n\n不是一个摆好姿势、等人夸赞的我。",
		"choices": [
			{"label": "你在这里，今晚就已经不一样了。", "next": "core_present"},
			{"label": "我看见了，你一直在等别人先说话。", "next": "core_waiting"},
			{"label": "我先不说话。让我好好看看你。", "next": "core_silence"},
		],
	},
	"core_present": {
		"speaker": "爱慕虚荣的人",
		"animation": "laugh_02_001",
		"text": "再说一次。刚才太快了，我还没准备好相信。",
		"choices": [
			{"label": "我不会一直说。可是这一句是真的。", "next": "core_present_reply"},
		],
	},
	"core_present_reply": {
		"speaker": "爱慕虚荣的人",
		"animation": "agree_001",
		"text": "原来真正的话，反而让人不敢立刻接住。",
		"narration": "他的手停在帽檐上，忘了继续摆出已经练过很多次的角度。",
		"choices": [
			{"label": "接不住也没关系。让它先在这里待一会儿。", "next": "reflection"},
		],
	},
	"core_waiting": {
		"speaker": "爱慕虚荣的人",
		"animation": "look_around_001",
		"text": "等别人开口……听起来一点也不像舞台上的台词。",
		"choices": [
			{"label": "可是我觉得，它就像你呀。", "next": "core_waiting_reply"},
		],
	},
	"core_waiting_reply": {
		"speaker": "爱慕虚荣的人",
		"animation": "laugh_02_001",
		"text": "你这样说，我可没办法再摆出最好看的角度了。",
		"narration": "他笑了一下。那笑容很短，却没有立刻去找镜子确认。",
		"choices": [
			{"label": "不用最好看。现在这样就很好。", "next": "reflection"},
		],
	},
	"core_silence": {
		"speaker": "爱慕虚荣的人",
		"animation": "agree_001",
		"text": "不说话？那我和镜子里的人还有什么区别。",
		"choices": [
			{"label": "镜子不会因为有人看着它，就紧张得不知道怎么办呀。", "next": "core_silence_reply"},
		],
	},
	"core_silence_reply": {
		"speaker": "爱慕虚荣的人",
		"animation": "agree_001",
		"text": "……那我最好先别动。别让你看见我紧张。",
		"narration": "他站得笔直，手指却在袖口后面轻轻绞了一下。",
		"choices": [
			{"label": "我看见了。没关系呀。", "next": "reflection"},
		],
	},
	"reflection": {
		"speaker": "爱慕虚荣的人",
		"animation": "look_around_001",
		"text": "我总以为，掌声够多，我就能变成一个更完整的人。\n\n可每次掌声停下，我都觉得自己被留在台上。",
		"narration": "镜脚边的花瓣被风带着移动了一点，像一群终于坐下的观众。",
		"choices": [
			{"label": "舞台不能替你过日子。不过今晚，我可以当你的观众。", "next": "ending"},
		],
	},
	"ending": {
		"speaker": "爱慕虚荣的人",
		"animation": "agree_001",
		"text": "那就只借你一次掌声。\n\n等掌声停下来以后，你还在吗？",
		"narration": "他把帽子摘下来，没有再举高。",
		"choices": [
			{"label": "结束对话", "action": "begin_vain_applause"},
		],
	},
}


const MERCHANT_DIALOGUE_NODES := {
	"intro": {
		"speaker": "商人",
		"text": "别碰那排算珠。账目刚到五亿零一百六十二万。\n\n你来得正好。站远一点，别让影子落在最后一行数字上。",
		"choices": [
			{"id": "look_up", "label": "你数了这么多星星，还记得上次抬头是什么时候吗？", "next": "look_up"},
			{"id": "brightness", "label": "写进本子里的星星，会亮得更久吗？", "next": "brightness"},
			{"id": "lights", "label": "头顶那串灯也有号码吗？", "next": "lights"},
			{"label": "如果今晚不记账，你最想抬头看什么？", "next": "core"},
		],
	},
	"look_up": {
		"speaker": "商人",
		"text": "抬头会漏数。\n\n账本至少不会从窗边逃走。",
		"narration": "他的笔尖停在一格空白上，像是在计算抬头要损失多少时间。",
		"returns_to_menu": true,
		"choices": [],
	},
	"brightness": {
		"speaker": "商人",
		"text": "不会。\n\n但别人就不能说它们不是我的。",
		"narration": "他把烛台挪远了一些，免得火光照亮账本上看不见的东西。",
		"returns_to_menu": true,
		"choices": [],
	},
	"lights": {
		"speaker": "商人",
		"text": "十二盏，都有。\n\n最右边那盏总闪，可它仍然属于我。",
		"narration": "那串灯正安静地亮着。最右边的一盏闪了一下，像是没有听见自己的编号。",
		"returns_to_menu": true,
		"choices": [],
	},
	"core": {
		"speaker": "商人",
		"text": "不记账？\n\n那我怎么知道，刚才看见的光还在不在？",
		"choices": [
			{"label": "就核那颗已经不亮的吧。", "next": "core_dark"},
			{"label": "就核那颗你没有写进本子的吧。", "next": "core_unnumbered"},
			{"label": "先别选星星。让我看看你的本子吧。", "next": "core_ledger"},
		],
	},
	"core_dark": {
		"speaker": "商人",
		"text": "第 501,620,001 号。\n\n它昨天还在，今天缺了一格。",
		"narration": "他把笔尖按在那一行上，纸上留下一个比数字更深的墨点。",
		"choices": [
			{"label": "那我们先把它找回来吧。", "next": "reflection"},
		],
	},
	"core_unnumbered": {
		"speaker": "商人",
		"text": "没有这种星。每颗我都有编号。",
		"narration": "他说完，头顶最右边那盏灯又闪了一下。那里的星签是空白的。",
		"choices": [
			{"label": "那串灯好像没有写名字呀。", "next": "core_unnumbered_reply"},
		],
	},
	"core_unnumbered_reply": {
		"speaker": "商人",
		"text": "灯是灯，星是星。不要把它们混在一起。",
		"choices": [
			{"label": "可你抬头看的时候，看到的不是一样的光吗？", "next": "reflection"},
		],
	},
	"core_ledger": {
		"speaker": "商人",
		"text": "账本不是故事书。",
		"narration": "他嘴上拒绝，还是把最厚的一本推了过来。每一页都写满了相似的编号。",
		"choices": [
			{"label": "每一颗都写得一模一样。难怪你认不出它们。", "next": "core_ledger_reply"},
		],
	},
	"core_ledger_reply": {
		"speaker": "商人",
		"text": "一样才不会出错。",
		"choices": [
			{"label": "可是星星亮着，本来就不是为了不写错呀。", "next": "reflection"},
		],
	},
	"reflection": {
		"speaker": "商人",
		"text": "我一直以为，记得数字就等于记住了星星。\n\n只要它们还有编号，我就不必想它们会不会熄灭，也不必想今晚有没有人抬头。",
		"narration": "算盘静止下来。厚账簿压着桌角，像压住了一整片夜空。",
		"choices": [
			{"label": "那就核一颗吧。不是把它关进本子里，只是看看它还在不在亮。", "next": "ending"},
		],
	},
	"ending": {
		"speaker": "商人",
		"text": "……好。只核一颗。",
		"narration": "敞开的抽屉里，写着号码的星签轻轻碰了一下木板。",
		"choices": [
			{"label": "结束对话", "action": "begin_merchant_tally"},
		],
	},
}


const FOX_DIALOGUE_NODES := {
	"intro": {
		"speaker": "狐狸",
		"text": "你来了。风刚刚停过一次，我还以为那就是你的脚步。\n\n请驯养我吧。不是让我成为你的，而是让麦子的颜色以后都记得你。",
		"choices": [
			{"id": "tame", "label": "驯养是什么意思？", "next": "tame"},
			{"id": "wait", "label": "为什么一定要等？", "next": "wait"},
			{"id": "leave", "label": "如果我还是会离开呢？", "next": "leave"},
			{"label": "那如果今天什么都不发生，我们还会记得彼此吗？", "next": "core"},
		],
	},
	"tame": {
		"speaker": "狐狸",
		"text": "就是约定一个时刻。\n\n你下午四点来，我从三点起就会开始高兴。",
		"narration": "狐狸的尾巴轻轻扫过麦穗。整片麦田像因此知道了一个时间。",
		"returns_to_menu": true,
		"choices": [],
	},
	"wait": {
		"speaker": "狐狸",
		"text": "因为等待不是在消耗时间。\n\n它是在给相遇留一个位置。",
		"narration": "风吹过来时，狐狸先听见了麦子的声音，然后才看向小王子。",
		"returns_to_menu": true,
		"choices": [],
	},
	"leave": {
		"speaker": "狐狸",
		"text": "我会记得你，麦子也会。\n\n离开不能把已经发生的事收回去。",
		"narration": "狐狸没有把目光移开。麦浪向远处弯去，又慢慢抬起头。",
		"returns_to_menu": true,
		"choices": [],
	},
	"core": {
		"speaker": "狐狸",
		"text": "先别急着说以后。\n\n今天的风刚好，麦子也还在响。要不要先坐一会儿？",
		"choices": [
			{"label": "我陪你坐一会儿。哪里也不去。", "next": "core_last_light"},
			{"label": "今天可以什么话都不说吗？", "next": "core_silence"},
			{"label": "太阳落下去以后，我们算什么呢？", "next": "core_after"},
		],
	},
	"core_last_light": {
		"speaker": "狐狸",
		"text": "可以。只是别把每一秒都用来害怕它结束。",
		"choices": [
			{"label": "那我就先看现在吧。", "next": "core_last_light_reply"},
		],
	},
	"core_last_light_reply": {
		"speaker": "狐狸",
		"text": "现在有麦子，有风，还有一个说话很慢的人。\n\n已经够了。",
		"narration": "他往旁边挪了半步，在麦田间留出一小块可以坐下的地方。",
		"choices": [
			{"label": "那我坐近一点，好吗？", "next": "reflection"},
		],
	},
	"core_silence": {
		"speaker": "狐狸",
		"text": "可以。\n\n听风，听麦子，听我什么时候呼吸。",
		"choices": [
			{"label": "我在听。", "next": "core_silence_reply"},
		],
	},
	"core_silence_reply": {
		"speaker": "狐狸",
		"text": "那就别急着听懂。先待在这里。",
		"narration": "风穿过麦田，又安静下来。谁都没有急着填补那一段沉默。",
		"choices": [
			{"label": "好呀。我们就这样等一会儿。", "next": "reflection"},
		],
	},
	"core_after": {
		"speaker": "狐狸",
		"text": "算一起看过一场日落的人。\n\n这个称呼，不需要每天兑现。",
		"choices": [
			{"label": "那今天这样就够了。", "next": "core_after_reply"},
		],
	},
	"core_after_reply": {
		"speaker": "狐狸",
		"text": "今天本来就已经是一整天。",
		"narration": "太阳贴着星球边缘，麦穗的影子被拉得很长。",
		"choices": [
			{"label": "那我们先把今天过完吧。", "next": "reflection"},
		],
	},
	"reflection": {
		"speaker": "狐狸",
		"text": "人们总说驯养就是拥有。\n\n其实只是，在你离开以后，我还认得你的脚步声。",
		"narration": "太阳靠近星球边缘，麦穗一层一层换成更深的金色。",
		"choices": [
			{"label": "我们一起等到日落吧。", "next": "ending"},
		],
	},
	"ending": {
		"speaker": "狐狸",
		"text": "好。\n\n别坐得太远。日落只有一次。",
		"narration": "风从麦田里穿过，留下一个可以并肩坐下的位置。",
		"choices": [
			{"label": "结束对话", "action": "begin_fox_sunset"},
		],
	},
}


const NODES_BY_SCENE := {
	"pointlighter": POINTLIGHTER_DIALOGUE_NODES,
	"rose": ROSE_DIALOGUE_NODES,
	"vain": VAIN_DIALOGUE_NODES,
	"merchant": MERCHANT_DIALOGUE_NODES,
	"earth": FOX_DIALOGUE_NODES,
}
