extends RefCounted


const TITLE := "小王子 · 我的星球"


const NODES := {
	"intro": {
		"text": "你想问什么？这一次，我不用赶着去看日落。\n\n这些星球我们已经一起看过了。可有些事，我还在想。",
		"choices": [
			{
				"id": "player_topic_rose",
				"label": "你怎么看玫瑰？",
				"next": "rose",
			},
			{
				"id": "player_topic_king",
				"label": "国王没有臣民，为什么还要命令太阳落下？",
				"next": "king",
			},
			{
				"id": "player_topic_vain",
				"label": "爱慕虚荣的人为什么那么在意掌声？",
				"next": "vain",
			},
			{
				"id": "player_topic_merchant",
				"label": "商人说星星都属于他，你觉得他说得对吗？",
				"next": "merchant",
			},
			{
				"id": "player_topic_lamplighter",
				"label": "点灯人为什么不肯停下来？",
				"next": "lamplighter",
			},
			{
				"id": "player_topic_fox",
				"label": "狐狸说驯养会让人难过，为什么还要靠近？",
				"next": "fox",
			},
			{
				"id": "player_topic_me",
				"label": "你怎么看我？",
				"next": "me",
			},
			{"label": "先不问了，陪你待一会儿", "action": "close"},
		],
	},
	"rose": {
		"text": "有一点。她说的和想要的，常常不是同一件事。\n\n可如果我只听她说了什么，就会忘记看她把刺收起来的时候。",
		"choices": [
			{"label": "她是在故意为难你吗？", "next": "rose_hard"},
			{"label": "你现在还会想她吗？", "next": "rose_miss"},
		],
	},
	"rose_hard": {
		"text": "有时候是。她怕我不看她，就先让我不得不看她。\n\n我不喜欢这样，可我也不能只把她当成一根会痛的刺。",
		"returns_to_menu": true,
		"choices": [],
	},
	"rose_miss": {
		"text": "会。看到玻璃上的雾、风吹起叶子，或者一朵花沉默得太久，我都会想。\n\n想念不是一定要回去。它只是说明，有段时间真的留在我心里了。",
		"returns_to_menu": true,
		"choices": [],
	},
	"king": {
		"text": "因为命令别人，比等一颗星自己转完一圈容易。\n\n他手里没有握住太阳，只握住了“我说了算”这句话。",
		"choices": [
			{"label": "你害怕自己也变成那样吗？", "next": "king_afraid"},
			{"label": "权力能让人不孤单吗？", "next": "king_lonely"},
		],
	},
	"king_afraid": {
		"text": "有一点。\n\n我有时也想让别人立刻回答我，好证明我没有白问。可真正重要的事，好像都不能被命令赶来。",
		"returns_to_menu": true,
		"choices": [],
	},
	"king_lonely": {
		"text": "大概不能。国王的星球上坐满了命令，却没有一个人坐在他旁边。\n\n如果一个人只能听见自己的回声，他说得再大声，也还是一个人。",
		"returns_to_menu": true,
		"choices": [],
	},
	"vain": {
		"text": "他把别人的眼睛当成了镜子。掌声一停，就不知道自己在哪儿。\n\n可镜子只能照见正面。他错过了背面那些没人鼓掌，也仍然属于他的东西。",
		"choices": [
			{"label": "他只是喜欢被夸吗？", "next": "vain_praise"},
			{"label": "如果没人看他，他会难过吗？", "next": "vain_alone"},
		],
	},
	"vain_praise": {
		"text": "不只是。\n\n他更像在问：“我在这里吗？”只是他只会用让别人夸他的方式问。",
		"returns_to_menu": true,
		"choices": [],
	},
	"vain_alone": {
		"text": "会。但安静下来，也许是他第一次有机会看看自己。\n\n不用一直漂亮，不用一直正确，也还是可以待在那里。",
		"returns_to_menu": true,
		"choices": [],
	},
	"merchant": {
		"text": "他数得很快，记得也很整齐。\n\n可我从没见他抬头看一颗星。他拥有的是一串数字，不是一片夜空。",
		"choices": [
			{"label": "拥有和照顾有什么不同？", "next": "merchant_care"},
			{"label": "你会觉得他很可怜吗？", "next": "merchant_pity"},
		],
	},
	"merchant_care": {
		"text": "拥有是把名字写进账本，照顾是会记得它什么时候需要水、什么时候害怕风。\n\n账本不会替你等一朵花开。",
		"returns_to_menu": true,
		"choices": [],
	},
	"merchant_pity": {
		"text": "我不会这样说。\n\n他只是太忙了，忙到没有时间问自己：算完以后，要抬头做什么？",
		"returns_to_menu": true,
		"choices": [],
	},
	"lamplighter": {
		"text": "他怕一停下来，自己就不再是点灯人了。\n\n可一盏灯亮着，不等同于点灯的人必须一直跑。",
		"choices": [
			{"label": "你敬佩他吗？", "next": "lamplighter_respect"},
			{"label": "如果是你，会放下那盏灯吗？", "next": "lamplighter_choice"},
		],
	},
	"lamplighter_respect": {
		"text": "敬佩。他做的是别人的事，却认真得像在守一颗星。\n\n我也希望他能有一个不用证明什么的分钟。",
		"returns_to_menu": true,
		"choices": [],
	},
	"lamplighter_choice": {
		"text": "我不知道。\n\n也许我不会把灯弄灭。我只会坐下来，陪它亮一会儿，等风替我们决定下一步。",
		"returns_to_menu": true,
		"choices": [],
	},
	"fox": {
		"text": "因为难过不是全部。\n\n以前麦田只是麦田。后来风吹过时，我会先听见狐狸，再想起金色。",
		"choices": [
			{"label": "你后悔认识他吗？", "next": "fox_regret"},
			{"label": "关系一定会让人难过吗？", "next": "fox_sad"},
		],
	},
	"fox_regret": {
		"text": "不后悔。\n\n如果知道最后会分开就不开始，我也错过了许多本来能一起看见的东西。",
		"returns_to_menu": true,
		"choices": [],
	},
	"fox_sad": {
		"text": "不一定。\n\n但关系一定会在心里留下一些只能由某个人解释的东西。难过只是其中一种。",
		"returns_to_menu": true,
		"choices": [],
	},
	"me": {
		"text": "你和小时候的我不太一样。\n\n你会先问“为什么”，不是只告诉我“应该是这样”。所以和你一起走的时候，我会觉得世界还没有被说完。",
		"choices": [
			{"label": "我如果做错了，你会失望吗？", "next": "me_wrong"},
			{"label": "你希望我记住你，还是继续往前走？", "next": "me_remember"},
			{"label": "我是不是也只是你旅途里的一个过路人？", "next": "me_pass"},
		],
	},
	"me_wrong": {
		"text": "如果你做错了又假装没有看见，我可能会失望。\n\n如果你说“我不知道”，然后愿意再走近一点，那就只是我们还没找到答案。",
		"returns_to_menu": true,
		"choices": [],
	},
	"me_remember": {
		"text": "我希望你往前走的时候，偶尔想起我。\n\n我不要你停在原地守着一颗星。星星愿意被记得，不是为了让赶路的人回头。",
		"returns_to_menu": true,
		"choices": [],
	},
	"me_pass": {
		"text": "过路人会经过。\n\n可有些过路人会留下一个记号，让后来看到同样的花、同样的河，知道曾经有人和自己一起看过。\n\n你不是占了很长的时间。你是让一段时间变得可以认出来。",
		"returns_to_menu": true,
		"choices": [],
	},
}
