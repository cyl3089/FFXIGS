require('GUI')
require('Modes')
include('weather_obi')
function setup()
	AccuracyMode = M{['description']='Accuracy Mode', 'Normal', 'Mid', 'High'}
	
	WeaponMode = M{['description']='Weapon', 'Naegling', 'Almace'}
	
	EngagedMode = M{['description']='Engaged Mode', 'Normal', 'Hybrid', 'DT'}
	IdleMode = M{['description']='Idle Mode', 'Normal', 'Meva'}
	
	Obi_WS = T{ -- Any weaponskills we want to check weather/day and use the obi
		--'Cloudsplitter',
	}
	
	WeaponTable = {
		['Naegling'] = {main="クロセアモース", type='Sword', img='COR/Crocea Mors.png'},
		['Almace'] = {main="ネイグリング", type='Sword', img='COR/Naegling.png'}
--		['Sequence'] = {main="セクエンス", type='Sword', img='COR/Sequence.png'}
	}
	
	selfCommandMaps = {
		['set']		= function(arg) _G[arg[1]]:set(table.concat(table.slice(arg, 2, -1)," ")); update_gear() end, 
		['toggle']	= function(arg) _G[arg[1]]:toggle(); update_gear() end,
		['cycle']	= function(arg) _G[arg[1]]:cycle(); update_gear() end,
		['cycleback']	= function(arg) _G[arg[1]]:cycleback(); update_gear() end,
		['update']	= update_gear,
		['cursna']	= function() equip(sets.Cursna) end,
		['cure']	= function() equip(sets.Cure) end,
		}
		
	build_GUI()
	bind_keys()
end

function get_sets()
    set_language('japanese')
	setup()
	
	Smertrios = {}
	Smertrios.Acc = {name="スメルトリオマント", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
	Smertrios.WSD = {name="スメルトリオマント", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
		
	Valorous = {}
	Valorous.Head = {}
	Valorous.Head.WSD = { name="バロラスマスク", augments={'Accuracy+17 Attack+17','Weapon skill damage +8%','STR+15',}}
	Valorous.Head.Crit = { name="Valorous Mask", augments={'Accuracy+14','Crit. hit damage +4%','STR+13','Attack+4',}}
	Valorous.Body = {}
	Valorous.Body.STP = {name="Valorous Mail", augments={'INT+10','MND+4','"Store TP"+9','Mag. Acc.+1 "Mag.Atk.Bns."+1'}}
	Valorous.Body.MAB = {name="ファウンダブレスト", augments={'Accuracy+15','Mag. Acc.+15','Attack+15','"Mag.Atk.Bns."+15',}}
	  
    init_elemental_obi()
    set_elemental_obi("光輪の帯")

    sets.precast = {}
    sets.precast.ws = {}
    sets.precast.ability = {}
    sets.midcast = {}
    sets.aftercast = {}
    sets.weapon = {}

    -- レジストハック装備
    is_immunobreak = false

    is_cure_self = false

    is_dw = false

    -- メインサブ武器変更
    melee_weapon_cycle_num = 3
    melee_weapon_cycle = 0
    melee_weapon = 'tauret'

    sets.magic_enhance_skill = T{'ストライ', 'ストライII',
                                'エンサンダー', 'エンストーン', 'エンエアロ', 'エンブリザド', 'エンファイア', 'エンウォータ',
                                'エンサンダーII', 'エンストーンII', 'エンエアロII', 'エンブリザドII', 'エンファイアII', 'エンウォータII',}

    sets.magic_enhance_skill_500 = T{'バストンラ', 'バウォタラ', 'バエアロラ', 'バファイラ', 'バブリザラ', 'バサンダラ',
                                    'バストン', 'バウォタ', 'バエアロ', 'バファイ', 'バブリザ', 'バサンダ', 'オーラ',}
    sets.magic_gain = T{ 'ゲインバイト', 'ゲインマイン', 'ゲインカリス', 'ゲインアジル', 'ゲインスト', 'ゲインイン', 'ゲインデック',}
    sets.magic_enfeeble_mnd = T{'パライズ', 'パライズII', 'スロウ', 'スロウII', 'アドル', 'アドルII',}
    sets.magic_enfeeble_mnd_and_skill = T{'ディストラ', 'ディストラII', 'ディストラIII', 'フラズルIII', 'ポイズン', 'ポイズンII',}
    sets.magic_enfeeble_mnd_acc = T{'ディア', 'ディアII', 'ディアIII', 'サイレス', 'フラズル', 'フラズルII',}
    sets.magic_enfeeble_int = T{'ブライン', 'ブラインII', 'グラビデ', 'グラビデII',}
    sets.magic_enfeeble_int_acc = T{'スリプル', 'スリプルII', 'スリプガ', 'バインド', 'ブレイク'}
    sets.magic_enfeeble_duration_sabo = T{'スリプル', 'スリプルII', 'スリプガ', 'バインド', 'ブレイク', 'サイレス','ディア', 'ディアII', 'ディアIII','ポイズン', 'ポイズンII',}

    sets.weapon.hist = {main=empty, sub=empty}

    sets.weapon.tauret = {main="トーレット", sub="サクロバルワーク",}
    sets.weapon.naegling = {main="ネイグリング", sub="サクロバルワーク",}
    sets.weapon.d1 = {main="クトゥルブナイフ", sub="サクロバルワーク",}
    sets.weapon.crocea = {main="クロセアモース", sub="サクロバルワーク",}
    
    sets.weapon.tauret_nin = {main="トーレット", sub="ターニオンダガー+1",}
    sets.weapon.naegling_nin = {main="ネイグリング", sub="ターニオンダガー+1",}
    sets.weapon.d1_nin = {main="クトゥルブナイフ", sub="アーンダガー",}
    sets.weapon.crocea_nin = {main="クロセアモース", sub="ターニオンダガー+1",}
    sets.weapon.crocea_daybreak_nin = {main="クロセアモース", sub="デイブレイクワンド",}

    sets.weapon.enfeeble_mnd = {main="デイブレイクワンド", sub="アムラピシールド",}
    sets.weapon.enfeeble_mnd_nin = {main="マクセンチアス", sub="デイブレイクワンド",}

    sets.weapon.enfeeble_dispelga = {main="デイブレイクワンド", sub="マクセンチアス",}

    sets.weapon.enfeeble_int = {main="ネイグリング", sub="アムラピシールド",}
    sets.weapon.enfeeble_int_nin = {main="ネイグリング", sub="マクセンチアス",}

    sets.weapon.enfeeble_acc = {main="クロセアモース", sub="アムラピシールド",}
    sets.weapon.enfeeble_acc_nin = {main="クロセアモース", sub="マクセンチアス",}

    sets.th = {
        head="白ララブキャップ+1",
        legs={ name="マーリンシャルワ", augments={'CHR+9','MND+2','"Treasure Hunter"+2',}},
        waist="チャークベルト",
    }

    sets.precast.fc = {
    head="ＡＴシャポー+1",
    body={ name="ＶＩタバード+1", augments={'Enhances "Chainspell" effect',}},
    hands={ name="レイライングローブ", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
    legs={ name="サイクロスラッパ", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="マーリンクラッコー", augments={'"Fast Cast"+6',}},
    neck="ベーテルペンダント",
    waist="エンブラサッシュ",
    left_ear="マリグナスピアス",
    right_ear="エテオレートピアス",
    left_ring="キシャールリング",
    right_ring="プロリクスリング",
    back={ name="スセロスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
}

    sets.precast.ws.magic = {
        ammo="ペムフレドタスラム",
        head="ジャリコロナル+2",
        body={ name="マーリンジュバ", augments={'AGI+8','"Mag.Atk.Bns."+24','Weapon skill damage +7%','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
        hands="ジャリカフス+2",
        legs={ name="ＡＭスロップス+1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        feet={ name="ＡＭネール+1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        neck="フォシャゴルゲット",
        waist="オルペウスサッシュ",
        left_ear="マリグナスピアス",
        right_ear={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
        left_ring="フレキリング",
        right_ring="女王の指輪+1",
        back={ name="スセロスケープ", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Damage taken-5%',}},
    }
    
    sets.precast.ws.magic_dark = {
        ammo="ペムフレドタスラム",
        head="妖蟲の髪飾り+1",
        body={ name="マーリンジュバ", augments={'AGI+8','"Mag.Atk.Bns."+24','Weapon skill damage +7%','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
        hands="ジャリカフス+2",
        legs={ name="ＡＭスロップス+1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        feet={ name="ＡＭネール+1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        neck="水影の首飾り",
        waist="オルペウスサッシュ",
        left_ear="マリグナスピアス",
        right_ear="王将の耳飾り",
        left_ring="フレキリング",
        right_ring="アルコンリング",
        back={ name="スセロスケープ", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Damage taken-5%',}},
    }

    sets.precast.ws.multi = {

    head="ジャリコロナル+2",
    body="ジャリローブ+2",
    hands="ジャリカフス+2",
    legs="ジャリスロップス+2",
    feet="ジャリピガッシュ+2",
    neck="フォシャゴルゲット",
    waist={ name="セールフィベルト+1", augments={'Path: A',}},
    left_ear="イシュヴァラピアス",
    right_ear={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="ペトロフリング",
    right_ring="ＫＲリング+1",
    back={ name="スセロスケープ", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}

    sets.precast.ws['ガストスラッシュ'] = sets.precast.ws.magic
    sets.precast.ws['サイクロン'] = sets.precast.ws.magic
    sets.precast.ws['エナジースティール'] = sets.precast.ws.magic
    sets.precast.ws['エナジードレイン'] = sets.precast.ws.magic
    sets.precast.ws['イオリアンエッジ'] = sets.precast.ws.magic
    sets.precast.ws['エヴィサレーション'] = sets.precast.ws.multi
    
    sets.precast.ws['バーニングブレード'] = sets.precast.ws.magic
    sets.precast.ws['レッドロータス'] = sets.precast.ws.magic
    sets.precast.ws['シャインブレード'] = sets.precast.ws.magic
    sets.precast.ws['セラフブレード'] = sets.precast.ws.magic
    sets.precast.ws['サンギンブレード'] = sets.precast.ws.magic_dark
    sets.precast.ws['サベッジブレード'] = sets.precast.ws.multi
    sets.precast.ws['シャンデュシニュ'] = sets.precast.ws.multi
    sets.precast.ws['レクイエスカット'] = sets.precast.ws.multi

    sets.precast.ability['連続魔'] = {body={ name="ＶＩタバード+3", augments={'Enhances "Chainspell" effect',}},}

    sets.midcast.enhance_duration_self = {
        -- sub="アムラピシールド",
    head="ビファウルクラウン",
    body={ name="ＶＩタバード+1", augments={'Enhances "Chainspell" effect',}},
    hands={ name="ＶＩグローブ+1", augments={'Enhancing Magic duration',}},
    legs="ＡＴタイツ+2",
    feet="ＬＴウゾー+1",
    neck="デュエルトルク+2",
    waist="エンブラサッシュ",
    left_ear="マリグナスピアス",
    right_ear="ディグニタリピアス",
    left_ring="スティキニリング",
    right_ring="スティキニリング",
    back={ name="スセロスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
}

    sets.midcast.enhance_duration_others = {
        -- sub="アムラピシールド",
    head="ビファウルクラウン",
    body={ name="ＶＩタバード+1", augments={'Enhances "Chainspell" effect',}},
    hands={ name="ＶＩグローブ+1", augments={'Enhancing Magic duration',}},
    legs="ＡＴタイツ+2",
    feet="ＬＴウゾー+1",
    neck="デュエルトルク+2",
    waist="エンブラサッシュ",
    left_ear="マリグナスピアス",
    right_ear="ディグニタリピアス",
    left_ring="スティキニリング",
    right_ring="スティキニリング",
    back={ name="スセロスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
}

    sets.midcast.enhance_skill = {
--    main="プクラトムージュ+1",
    sub="プクラトムージュ+1",
    head="ビファウルクラウン",
    body={ name="ＶＩタバード+1", augments={'Enhances "Chainspell" effect',}},
    hands={ name="ＶＩグローブ+1", augments={'Enhancing Magic duration',}},
    legs="ＡＴタイツ+2",
    feet="ＬＴウゾー+1",
    neck="デュエルトルク+2",
    waist="エンブラサッシュ",
    left_ear="マリグナスピアス",
    right_ear="ディグニタリピアス",
    left_ring="スティキニリング",
    right_ring="スティキニリング",
    back="ゴストファイケープ",
    }

    sets.midcast.enhance_skill_500 = {
        -- sub="アムラピシールド",
    head="ビファウルクラウン",
    body={ name="ＶＩタバード+1", augments={'Enhances "Chainspell" effect',}},
    hands="王将の袖飾り",
    legs="ＡＴタイツ+2",
    feet="ＬＴウゾー+1",
    neck="デュエルトルク+2",
    waist="エンブラサッシュ",
    left_ear="マリグナスピアス",
    right_ear="ディグニタリピアス",
    left_ring="スティキニリング",
    right_ring="スティキニリング",
    back={ name="スセロスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
}

    sets.midcast.ba = set_combine(sets.midcast.enhance_skill_500, {legs="シェダルサラウィル",})
    sets.midcast.enhance_gain = set_combine(sets.midcast.enhance_skill_500, {hands="ＶＩグローブ+3",})

    -- 強化スキル 500, 被ファランクス 17 (35+17=52)
    sets.midcast.phalanx_self = {
--        main="エグキング",
--        sub="アムラピシールド",
        head={ name="テーオンシャポー", augments={'Phalanx +3',}},
        body={ name="テーオンタバード", augments={'Phalanx +3',}},
        hands={ name="テーオングローブ", augments={'Phalanx +3',}},
        legs={ name="テーオンタイツ", augments={'Phalanx +3',}},
        feet={ name="テーオンブーツ", augments={'Phalanx +3',}},
        neck="インカンタートルク",
        waist="エンブラサッシュ",
        left_ear="アンドアーピアス",
        right_ear="ミミルピアス",
        left_ring="スティキニリング+1",
        right_ring="スティキニリング+1",
        back={ name="ゴストファイケープ", augments={'Enfb.mag. skill +9','Enha.mag. skill +10','Mag. Acc.+9','Enh. Mag. eff. dur. +19',}},
    }

    sets.midcast.phalanx_self_nin = {
--        main="プクラトムージュ+1",
--        sub="エグキング",
        head={ name="テーオンシャポー", augments={'Phalanx +3',}},
        body={ name="テーオンタバード", augments={'Phalanx +3',}},
        hands={ name="テーオングローブ", augments={'Phalanx +3',}},
        legs={ name="テーオンタイツ", augments={'Phalanx +3',}},
        feet={ name="テーオンブーツ", augments={'Phalanx +3',}},
        neck="デュエルトルク+2",
        waist="エンブラサッシュ",
        left_ear="アンドアーピアス",
        right_ear="ミミルピアス",
        left_ring="スティキニリング+1",
        right_ring="スティキニリング+1",
        back={ name="ゴストファイケープ", augments={'Enfb.mag. skill +9','Enha.mag. skill +10','Mag. Acc.+9','Enh. Mag. eff. dur. +19',}},
    }

    sets.midcast.phalanx = sets.midcast.phalanx_self

    sets.midcast.phalanx_others = set_combine(sets.midcast.enhance_duration_others, {left_ear="アンドアーピアス", right_ring="スティキニリング+1",})

    sets.midcast.cure = {
    head={ name="ヴァニヤフード", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body="アノインカラシリス",
    hands={ name="テルキネグローブ", augments={'"Fast Cast"+4',}},
    legs="ギーヴトラウザ",
    feet={ name="ケカスブーツ", augments={'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
    neck="ノデンズゴルゲット",
    waist="ギシドゥバサッシュ",
    left_ear="王将の耳飾り",
    right_ear="メンデカントピアス",
    left_ring="スティキニリング",
    right_ring="スティキニリング",
    back={ name="スセロスケープ", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}

    sets.midcast.skin = set_combine(sets.midcast.enhance_duration_self, {legs="シェダルサラウィル", neck='ノデンズゴルゲット', left_ear='アースクライピアス', waist="ジーゲルサッシュ",})
    sets.midcast.aquaveil = set_combine(sets.midcast.enhance_duration_self, {head="ＡＭコイフ+1", legs="シェダルサラウィル",})
    sets.midcast.refresh_self = set_combine(sets.midcast.enhance_duration_self, {head="ＡＭコイフ+1", body="ＡＴタバード+3",legs="ＬＴフュゾー+1",})
    sets.midcast.refresh_others = set_combine(sets.midcast.enhance_duration_others, {head="ＡＭコイフ+1", body="ＡＴタバード+3",legs="ＬＴフュゾー+1",})
    sets.midcast.protect_shell_self = set_combine(sets.midcast.enhance_duration_self, {right_ear="ブラキュラピアス",})

    sets.midcast.enfeeble_skill = {
--        main={ name="グリオアヴァール", augments={'Enfb.mag. skill +15','INT+14','Mag. Acc.+24','"Mag.Atk.Bns."+16',}},
--        sub="メフィテスグリップ",
    ammo="王将の玉",
    head={ name="ＶＩシャポー+1", augments={'Enfeebling Magic duration','Magic Accuracy',}},
    body="ＡＴタバード+3",
    hands="ＬＴガントロ+1",
    legs={ name="サイクロスラッパ", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="ＶＩブーツ+1", augments={'Immunobreak Chance',}},
    neck="デュエルトルク+2",
    waist="ルーミネリサッシュ",
    left_ear="マリグナスピアス",
    right_ear="ディグニタリピアス",
    left_ring="スティキニリング",
    right_ring="スティキニリング",
    back={ name="スセロスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
}
    sets.midcast.magic_enfeeble_mnd = {
    ammo="王将の玉",
    head={ name="ＶＩシャポー+1", augments={'Enfeebling Magic duration','Magic Accuracy',}},
    body="ＡＴタバード+3",
    hands="ＬＴガントロ+1",
    legs={ name="サイクロスラッパ", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="ＶＩブーツ+1", augments={'Immunobreak Chance',}},
    neck="デュエルトルク+2",
    waist="ルーミネリサッシュ",
    left_ear="マリグナスピアス",
    right_ear="ディグニタリピアス",
    left_ring="スティキニリング",
    right_ring="スティキニリング",
    back={ name="スセロスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
}

    sets.midcast.magic_enfeeble_mnd_and_skill = {
    ammo="王将の玉",
    head={ name="ＶＩシャポー+1", augments={'Enfeebling Magic duration','Magic Accuracy',}},
    body="ＡＴタバード+3",
    hands="ＬＴガントロ+1",
    legs={ name="サイクロスラッパ", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="ＶＩブーツ+1", augments={'Immunobreak Chance',}},
    neck="デュエルトルク+2",
    waist="ルーミネリサッシュ",
    left_ear="マリグナスピアス",
    right_ear="ディグニタリピアス",
    left_ring="スティキニリング",
    right_ring="スティキニリング",
    back={ name="スセロスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
}

    sets.midcast.magic_enfeeble_mnd_acc = {
    ammo="王将の玉",
    head={ name="ＶＩシャポー+1", augments={'Enfeebling Magic duration','Magic Accuracy',}},
    body="ＡＴタバード+3",
    hands="ＬＴガントロ+1",
    legs={ name="サイクロスラッパ", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="ＶＩブーツ+1", augments={'Immunobreak Chance',}},
    neck="デュエルトルク+2",
    waist="ルーミネリサッシュ",
    left_ear="マリグナスピアス",
    right_ear="ディグニタリピアス",
    left_ring="スティキニリング",
    right_ring="スティキニリング",
    back={ name="スセロスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
}
    
    sets.midcast.magic_enfeeble_int = {
    ammo="王将の玉",
    head={ name="ＶＩシャポー+1", augments={'Enfeebling Magic duration','Magic Accuracy',}},
    body="ＡＴタバード+3",
    hands="ＬＴガントロ+1",
    legs={ name="サイクロスラッパ", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="ＶＩブーツ+1", augments={'Immunobreak Chance',}},
    neck="デュエルトルク+2",
    waist="ルーミネリサッシュ",
    left_ear="マリグナスピアス",
    right_ear="ディグニタリピアス",
    left_ring="スティキニリング",
    right_ring="スティキニリング",
    back={ name="スセロスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
}

    sets.midcast.magic_enfeeble_int_acc = {
    ammo="王将の玉",
    head={ name="ＶＩシャポー+1", augments={'Enfeebling Magic duration','Magic Accuracy',}},
    body="ＡＴタバード+3",
    hands="ＬＴガントロ+1",
    legs={ name="サイクロスラッパ", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="ＶＩブーツ+1", augments={'Immunobreak Chance',}},
    neck="デュエルトルク+2",
    waist="ルーミネリサッシュ",
    left_ear="マリグナスピアス",
    right_ear="ディグニタリピアス",
    left_ring="スティキニリング",
    right_ring="スティキニリング",
    back={ name="スセロスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
}

    sets.midcast.magic_enfeeble_duration_sabo = {
    ammo="王将の玉",
    head={ name="ＶＩシャポー+1", augments={'Enfeebling Magic duration','Magic Accuracy',}},
    body="ＡＴタバード+3",
    hands="ＬＴガントロ+1",
    legs={ name="サイクロスラッパ", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="ＶＩブーツ+1", augments={'Immunobreak Chance',}},
    neck="デュエルトルク+2",
    waist="ルーミネリサッシュ",
    left_ear="マリグナスピアス",
    right_ear="ディグニタリピアス",
    left_ring="スティキニリング",
    right_ring="スティキニリング",
    back={ name="スセロスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
}

    sets.midcast.magic_acc = {
        range="ウルル",
        head="ＶＩシャポー+3",
        body="ＬＴサヨン+1",
        hands="ＬＴガントロ+1",
        legs={ name="カイロンホーズ", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Drain" and "Aspir" potency +2','INT+14','Mag. Acc.+13',}},
        feet="ＶＩブーツ+3",
        neck="デュエルトルク+2",
        waist="ルーミネリサッシュ",
        left_ear="スノトラピアス",
        right_ear="マリグナスピアス",
        left_ring="スティキニリング+1",
        right_ring="キシャールリング",
        back={ name="スセロスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
    }

    sets.midcast.magic_dispelga = {
        range="ウルル",
        head="ＶＩシャポー+3",
        body="ＬＴサヨン+1",
        hands="ＬＴガントロ+1",
        legs={ name="カイロンホーズ", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Drain" and "Aspir" potency +2','INT+14','Mag. Acc.+13',}},
        feet="ＶＩブーツ+3",
        neck="デュエルトルク+2",
        waist="ルーミネリサッシュ",
        left_ear="スノトラピアス",
        right_ear="マリグナスピアス",
        left_ring="スティキニリング+1",
        right_ring="キシャールリング",
        back={ name="スセロスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
    }

    sets.midcast.magic_mb = {
--        main={ name="グリオアヴァール", augments={'Spell interruption rate down -3%','INT+14','Mag. Acc.+29','"Mag.Atk.Bns."+29','Magic Damage +5',}},
--        sub="エンキストラップ",
        ammo="ペムフレドタスラム",
        head="エアハット+1",
        body={ name="マーリンジュバ", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst dmg.+6%','INT+7','Mag. Acc.+9','"Mag.Atk.Bns."+14',}},
        hands={ name="ＡＭゲージ+1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        legs={ name="マーリンシャルワ", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+9%','INT+13','"Mag.Atk.Bns."+1',}},
        feet="ジャリピガッシュ+2",
        neck="水影の首飾り",
        waist="サクロコード",
        left_ear="王将の耳飾り",
        right_ear="マリグナスピアス",
        left_ring="フレキリング",
        right_ring="女王の指輪+1",
        back={ name="スセロスケープ", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Damage taken-5%',}},
    }
	
	sets.idle = {}
	sets.idle.Normal = {
    ammo="ホミリアリ",
    head="ビファウルクラウン",
    body="ジャリローブ+2",
    hands="シュリーカーカフス",
    legs={ name="カマインクウィス+1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="マリグナスブーツ",
    neck={ name="ロリケートトルク+1", augments={'Path: A',}},
    waist="ギシドゥバサッシュ",
    left_ear="ハンドラーピアス+1",
    right_ear="エテオレートピアス",
    left_ring={ name="ゼラチナスリング+1", augments={'Path: A',}},
    right_ring="守りの指輪",
    back={ name="スセロスケープ", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},
}
	
	sets.idle['Meva'] = set_combine(sets.idle.Normal, { 
    ammo="ストンチタスラム+1",
    head="マリグナスシャポー",
    body="マリグナスタバード",
    hands="マリグナスグローブ",
    legs={ name="カマインクウィス+1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="マリグナスブーツ",
    neck={ name="ロリケートトルク+1", augments={'Path: A',}},
    waist={ name="セールフィベルト+1", augments={'Path: A',}},
    left_ear="ハンドラーピアス+1",
    right_ear="エテオレートピアス",
    left_ring={ name="ゼラチナスリング+1", augments={'Path: A',}},
    right_ring="守りの指輪",
    back={ name="スセロスケープ", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},
})
	
	-- Engaged Sets --
	
	sets.engaged = {
    ammo="銀銭",
    head="マリグナスシャポー",
    body="アヤモコラッツァ+2",
    hands="アヤモマノポラ+2",
    legs={ name="カマインクウィス+1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="マリグナスブーツ",
    neck={ name="ロリケートトルク+1", augments={'Path: A',}},
    waist="霊亀腰帯",
    left_ear="シェリダピアス",
--  right_ear="素破の耳",	
    right_ear="テロスピアス",
    left_ring="ペトロフリング",
    right_ring="イラブラットリング",
    back={ name="スセロスケープ", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},
}
	
	sets.engaged.Mid = set_combine(sets.engaged, {
--		body="Flamma Korazin +2",
	})
	
	sets.engaged.High = set_combine(sets.engaged.Mid, {
		ring2="Moonlight Ring" --"Regal Ring"
	})
	
	sets.engaged.Hybrid = {
    ammo="ストンチタスラム+1",
    head="ＡＴシャポー+1",
    body="マリグナスタバード",
    hands="マリグナスグローブ",
    legs={ name="カマインクウィス+1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="マリグナスブーツ",
    neck={ name="ロリケートトルク+1", augments={'Path: A',}},
    waist={ name="セールフィベルト+1", augments={'Path: A',}},
    left_ear="ハンドラーピアス+1",
    right_ear="エテオレートピアス",
    left_ring={ name="ゼラチナスリング+1", augments={'Path: A',}},
    right_ring="守りの指輪",
    back={ name="スセロスケープ", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},
}
	
	
	sets.engaged.DT = {
    ammo="ストンチタスラム+1",
    head="マリグナスシャポー",
    body="マリグナスタバード",
    hands="マリグナスグローブ",
    legs={ name="カマインクウィス+1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="マリグナスブーツ",
    neck={ name="ロリケートトルク+1", augments={'Path: A',}},
    waist={ name="セールフィベルト+1", augments={'Path: A',}},
    left_ear="ハンドラーピアス+1",
    right_ear="エテオレートピアス",
    left_ring={ name="ゼラチナスリング+1", augments={'Path: A',}},
    right_ring="守りの指輪",
    back={ name="スセロスケープ", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},
}

    -- 自己ケアル
    sets.hp_max_down = {
        ammo="チフィアスティング",
        head="妖蟲の髪飾り+1",
        body=empty,
        hands=empty,
        legs=empty,
        feet="コンデットシューズ",
        waist="スカウターロープ",
        left_ear="インフラクスピアス",
        right_ear="グライアピアス",
        left_ring="メフィタスリング",
        right_ring="メフィタスリング+1",
        back="ヴァテスケープ+1",
    }

    sets.midcast.cure_hp_max_down = {
        ammo="プシロメン",
        head={ name="ヴァニヤフード", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
        body="ヴリコダラジュポン",
        hands={ name="ブレムテグローブ", augments={'HP+30','MP+30','HP+30',}},
        legs="ＡＴタイツ+3",
        feet={ name="ヴァニヤクロッグ", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        neck="デュアルカラー+1",
        waist="ギシドゥバサッシュ",
        left_ear="エテオレートピアス",
        right_ear="メンデカントピアス",
        left_ring="クナジリング",
        right_ring="メネロスリング",
        back="月光の羽衣",
    }
--[[
    sets.aftercast.dw_30 = {
        legs={ name="カマインクウィス+1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="カマイングリーヴ+1", augments={'Accuracy+12','DEX+12','MND+20',}},
		--        feet={ name="テーオンブーツ", augments={'Accuracy+25','"Dual Wield"+5','DEX+10',}},
        right_ear="素破の耳",
        back={ name="スセロスケープ", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},
}
]]
--    send_command('wait 1; input //gs c ws')
    -- マクロのブック, セット変更
 --   send_command('input /macro book 16; wait 0.5; input /macro set 1; wait 0.5; input /si rdm;')
    send_command('input /macro book 16;wait .1;input /macro set 1;wait 1;input /lockstyleset 31')
end



function bind_keys()
	send_command('bind f9 gs c cycle AccuracyMode')
	send_command('bind f10 gs c set EngagedMode Hybrid')
	send_command('bind f11 gs c set EngagedMode DT')
	send_command('bind f12 gs c set EngagedMode Normal')
end

function file_unload()
	send_command('unbind f9')
	send_command('unbind f10')
	send_command('unbind f11')
	send_command('unbind f12')
end

function build_GUI()
	GUI_pos = {}
	GUI_pos.x = 1400
	GUI_pos.y = 120

	EM = IconButton{
		x = GUI_pos.x + 0,
		y = GUI_pos.y + 0,
		var = EngagedMode,
		icons = {
			{img = 'DD Normal.png', value = 'Normal'},
			{img = 'DD Hybrid.png', value = 'Hybrid'},
			{img = 'Emergancy DT.png', value = 'DT'}
		},
		command = 'gs c update'
	}
	EM:draw()
	
	local wi = {}
	for i,v in ipairs(WeaponMode) do
		wi[i] = {img=WeaponTable[v].img, value=v}
	end
	WM = IconButton{
		x = GUI_pos.x + 0,
		y = GUI_pos.y + 54,
		var = WeaponMode,
		icons = wi,
		command = 'gs c update'
	}
	WM:draw()
	
	AccDisplay = TextCycle{
		x = GUI_pos.x + 0,
		y = GUI_pos.y + 34 * 4,
		var = AccuracyMode,
		align = 'left',
		width = 112,
		command = 'gs c update'
	}
	AccDisplay:draw()
	IdleDisplay = TextCycle{
		x = GUI_pos.x + 0,
		y = GUI_pos.y + 34 * 4 + 32,
		var = IdleMode,
		align = 'left',
		width = 112,
		command = 'gs c update'
	}
	IdleDisplay:draw()
end

function self_command(commandArgs)
	local commandArgs = commandArgs
	if type(commandArgs) == 'string' then
		commandArgs = T(commandArgs:split(' '))
		if #commandArgs == 0 then
			return
		end
	end
	local handleCmd = table.remove(commandArgs, 1)
	if selfCommandMaps[handleCmd] then
		selfCommandMaps[handleCmd](commandArgs)
	end	
end


function get_idle_set()
	return set_combine(sets.idle[IdleMode.value], {main=WeaponTable[WeaponMode.value].main})
end

function get_engaged_set() -- sets.engaged[DefenseMode].(DW or WeaponMode).Accuracy.AM3
	local equipset = sets.engaged
	if equipset[EngagedMode.value] then
		equipset = equipset[EngagedMode.value]
	end
	if equipset[WeaponMode.value] then -- sets.engaged[DefenseMode]
		equipset = equipset[WeaponMode.value]
	elseif equipset[WeaponTable[WeaponMode.value].type] then -- type is greatkatana or polearm or whatever
		equipset = equipset[WeaponTable[WeaponMode.value].type]
	end
	if equipset[AccuracyMode.value] then
		equipset = equipset[AccuracyMode.value]
	end
	if equipset.AM3 and buffactive['Aftermath: Lv.3'] then
		equipset = equipset.AM3
	end
	
	if buffactive['Flash'] or buffactive['Blindness'] then
		equipset = set_combine(equipset, sets.Blind)
	end
	
	equipset = set_combine(equipset, {main=WeaponTable[WeaponMode.value].main})
	return equipset	
end

function update_gear() -- will put on the appropriate engaged or idle set
	if player.status == 'Engaged' then
		equip(get_engaged_set())
	else
		equip(get_idle_set())
	end
end







local function set_weapon_by_sub_job(sub_job, weapon)
    if sub_job == '忍' then
        sets.midcast.magic_enfeeble_mnd = set_combine(sets.midcast.magic_enfeeble_mnd, sets.weapon.enfeeble_mnd_nin)
        sets.midcast.magic_enfeeble_mnd_and_skill = set_combine(sets.midcast.magic_enfeeble_mnd_and_skill, sets.weapon.enfeeble_mnd_nin)
        sets.midcast.magic_enfeeble_mnd_acc = set_combine(sets.midcast.magic_enfeeble_mnd_acc, sets.weapon.enfeeble_mnd_nin)
        sets.midcast.magic_enfeeble_int = set_combine(sets.midcast.magic_enfeeble_int, sets.weapon.enfeeble_int_nin)
        sets.midcast.magic_enfeeble_int_acc = set_combine(sets.midcast.magic_enfeeble_int_acc, sets.weapon.enfeeble_int_nin)
        sets.midcast.magic_acc = set_combine(sets.midcast.magic_acc, sets.weapon.enfeeble_acc_nin)
        sets.midcast.magic_enfeeble_duration_sabo = set_combine(sets.midcast.magic_enfeeble_duration_sabo, sets.weapon.enfeeble_acc_nin)

        sets.midcast.magic_dispelga = set_combine(sets.midcast.magic_dispelga, sets.weapon.enfeeble_dispelga)

        sets.midcast.phalanx = sets.midcast.phalanx_self_nin

        if weapon == 'tauret' then
            sets.aftercast.melee = set_combine(sets.aftercast.melee, sets.weapon.tauret_nin)
            sets.aftercast.idle = set_combine(sets.aftercast.idle, sets.weapon.tauret_nin)
        elseif weapon == 'd1' then
            sets.aftercast.melee = set_combine(sets.aftercast.melee, sets.weapon.d1_nin)
            sets.aftercast.idle = set_combine(sets.aftercast.idle, sets.weapon.d1_nin)
        elseif weapon == 'crocea' then
            sets.aftercast.melee = set_combine(sets.aftercast.melee, sets.weapon.crocea_nin)
            sets.aftercast.idle = set_combine(sets.aftercast.idle, sets.weapon.crocea_nin)
        end
        
        if sets.weapon.hist.main ~= empty then
            sets.aftercast.melee = set_combine(sets.aftercast.melee, {main=sets.weapon.hist.main})
            sets.aftercast.idle = set_combine(sets.aftercast.idle, {main=sets.weapon.hist.main})
        end
        if sets.weapon.hist.sub ~= empty then
            sets.aftercast.melee = set_combine(sets.aftercast.melee, {sub=sets.weapon.hist.sub})
            sets.aftercast.idle = set_combine(sets.aftercast.idle, {sub=sets.weapon.hist.sub})
        end
 --       send_command('input /lockstyleset 4 echo;')
    else
        sets.midcast.magic_enfeeble_mnd = set_combine(sets.midcast.magic_enfeeble_mnd, sets.weapon.enfeeble_mnd)
        sets.midcast.magic_enfeeble_mnd_and_skill = set_combine(sets.midcast.magic_enfeeble_mnd_and_skill, sets.weapon.enfeeble_mnd)
        sets.midcast.magic_enfeeble_mnd_acc = set_combine(sets.midcast.magic_enfeeble_mnd_acc, sets.weapon.enfeeble_mnd)
        sets.midcast.magic_enfeeble_int = set_combine(sets.midcast.magic_enfeeble_int, sets.weapon.enfeeble_int)
        sets.midcast.magic_enfeeble_int_acc = set_combine(sets.midcast.magic_enfeeble_int_acc, sets.weapon.enfeeble_int)
        sets.midcast.magic_acc = set_combine(sets.midcast.magic_acc, sets.weapon.enfeeble_acc)
        sets.midcast.magic_enfeeble_duration_sabo = set_combine(sets.midcast.magic_enfeeble_duration_sabo, sets.weapon.enfeeble_acc)

        sets.midcast.magic_dispelga = set_combine(sets.midcast.magic_dispelga, sets.weapon.enfeeble_mnd)

        sets.midcast.phalanx = sets.midcast.phalanx_self

        sets.aftercast.melee = set_combine(sets.aftercast.melee, {back={ name="スセロスケープ", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}})
        sets.aftercast.idle = set_combine(sets.aftercast.idle, {back={ name="スセロスケープ", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}})

        if weapon == 'tauret' then
            sets.aftercast.melee = set_combine(sets.aftercast.melee, sets.weapon.tauret)
            sets.aftercast.idle = set_combine(sets.aftercast.idle, sets.weapon.tauret)
        elseif weapon == 'd1' then
            sets.aftercast.melee = set_combine(sets.aftercast.melee, sets.weapon.d1)
            sets.aftercast.idle = set_combine(sets.aftercast.idle, sets.weapon.d1)
        elseif weapon == 'crocea' or weapon == 'daybreak' then
            sets.aftercast.melee = set_combine(sets.aftercast.melee, sets.weapon.crocea)
            sets.aftercast.idle = set_combine(sets.aftercast.idle, sets.weapon.crocea)
        end

        if sets.weapon.hist.main ~= empty then
            sets.aftercast.melee = set_combine(sets.aftercast.melee, {main=sets.weapon.hist.main})
            sets.aftercast.idle = set_combine(sets.aftercast.idle, {main=sets.weapon.hist.main})
        end
--        send_command('input /lockstyleset 5 echo;')
    end
end

local function set_weapon_hist()
    if player.equipment.main ~= 'empty' then
        sets.weapon.hist.main = player.equipment.main
    end
    if player.equipment.sub ~= 'empty' then
        sets.weapon.hist.sub = player.equipment.sub
    end
    sets.aftercast.melee = set_combine(sets.aftercast.melee, sets.weapon.hist)
    sets.aftercast.idle = set_combine(sets.aftercast.idle, sets.weapon.hist)
end

function pretarget(spell)
    local set_equip = nil

    if is_cure_self then
        windower.add_to_chat(122,'---> HP MAX DOWN')
        set_equip = sets.hp_max_down
        is_cure_self = false
    end

    set_weapon_hist()

    if spell.name == 'ディスペガ' then
        set_equip = {main="デイブレイクワンド"}
    end

    if set_equip then
        equip(set_equip)
    end
end

function precast(spell)
    local set_equip = nil

    if spell.type == 'WhiteMagic' then
        set_equip = sets.precast.fc
    elseif spell.type == 'BlackMagic' then
        set_equip = sets.precast.fc
    elseif spell.type == 'JobAbility' then
        if sets.precast.ability[spell.name] then
            set_equip = sets.precast.ability[spell.name]
        end
    elseif spell.type == 'WeaponSkill' then
        if sets.precast.ws[spell.name] then
            set_equip = sets.precast.ws[spell.name]
        else
            set_equip = sets.precast.ws.multi
        end
    elseif spell.type == 'Ninjutsu' then
        set_equip = sets.precast.fc
    elseif spell.type == 'Trust' then
        set_equip = sets.precast.fc
    end

    if set_equip then
        equip(set_equip)
    end
end

function midcast(spell)
    local set_equip = nil

    if string.find(spell.name, 'ケアル') then
        if spell.target.type == 'SELF' then
            set_equip = sets.midcast.cure_hp_max_down
        else
            set_equip = set_combine(sets.midcast.cure, get_hachirin(spell.element))
        end
    elseif spell.skill == '強化魔法' then
        if spell.name == 'ストンスキン' then
            set_equip = sets.midcast.skin
        elseif spell.name == 'アクアベール' then
            set_equip = sets.midcast.aquaveil
        elseif string.find(spell.name, 'プロテ') or string.find(spell.name, 'シェル') then
            if spell.target.type == 'SELF' then
                set_equip = sets.midcast.protect_shell_self
            else
                set_equip = sets.midcast.enhance_duration_others
            end
        elseif string.find(spell.name, 'ファランクス') then
            if spell.target.type == 'SELF' then
                set_equip = sets.midcast.phalanx
            else
                set_equip = sets.midcast.phalanx_others
            end
        elseif sets.magic_enhance_skill:contains(spell.name) then
            set_equip = sets.midcast.enhance_skill
        elseif sets.magic_enhance_skill_500:contains(spell.name) then
            set_equip = sets.midcast.ba
        elseif sets.magic_gain:contains(spell.name) then
            set_equip = sets.midcast.enhance_gain
        elseif string.find(spell.name, 'デジョン') or string.find(spell.name, 'テレポ') or spell.name == 'リトレース' or spell.name == 'エスケプ' then
            set_equip = {waist="ニヌルタサッシュ",}
        elseif string.find(spell.name, 'リフレシュ') then
            if spell.target.type == 'SELF' then
                set_equip = sets.midcast.refresh_self
            else
                set_equip = sets.midcast.refresh_others
            end
        else
            if spell.target.type == 'SELF' then
                set_equip = sets.midcast.enhance_duration_self
            else
                set_equip = sets.midcast.enhance_duration_others
            end
        end
    elseif spell.skill == '弱体魔法' then
        if is_immunobreak then
            set_equip = sets.midcast.enfeeble_skill
            is_immunobreak = false
        elseif buffactive['サボトゥール'] and sets.magic_enfeeble_duration_sabo:contains(spell.name) then
            set_equip = sets.midcast.magic_enfeeble_duration_sabo
        elseif sets.magic_enfeeble_mnd:contains(spell.name) then
            set_equip = sets.midcast.magic_enfeeble_mnd
        elseif sets.magic_enfeeble_mnd_and_skill:contains(spell.name) then
            set_equip = sets.midcast.magic_enfeeble_mnd_and_skill
        elseif sets.magic_enfeeble_mnd_acc:contains(spell.name) then
            set_equip = sets.midcast.magic_enfeeble_mnd_acc
        elseif sets.magic_enfeeble_int:contains(spell.name) then
            set_equip = sets.midcast.magic_enfeeble_int
        elseif sets.magic_enfeeble_int_acc:contains(spell.name) then
            set_equip = sets.midcast.magic_enfeeble_int_acc
        elseif spell.name == 'ディスペガ' then
            set_equip = sets.midcast.magic_dispelga
        else
            set_equip = sets.midcast.magic_acc
        end
    elseif spell.skill == '暗黒魔法' then
        set_equip = sets.midcast.magic_acc
    elseif spell.skill == '精霊魔法' then
        set_equip = set_combine(sets.midcast.magic_mb, get_hachirin(spell.element))
    end

    if set_equip then
        equip(set_equip)
    end

end

function aftercast(spell)
    local set_equip = nil
    
    if player.status == 'Engaged' then
        if is_dw then
            set_equip = set_combine(sets.aftercast.melee, sets.aftercast.dw_30)
        else
            set_equip = sets.aftercast.melee
        end
    else
        set_equip = sets.aftercast.idle
    end
    
    if set_equip then
        equip(set_equip)
    end
end

function status_change(new, old)
    local set_equip = nil
    
    if new == 'Idle' then
        set_equip = sets.aftercast.idle
    elseif new == 'Engaged' then
        if is_dw then
            set_equip = set_combine(sets.aftercast.melee, sets.aftercast.dw_30)
        else
            set_equip = sets.aftercast.melee
        end
    end
    
    if set_equip then
        equip(set_equip)
    end
end
--[[
function self_command(command)
    if command == 'break' then
        is_immunobreak = not is_immunobreak
        windower.add_to_chat(122,'---> レジストハック: '..tostring(is_immunobreak))
    elseif command == 'wc' then
        melee_weapon_cycle = melee_weapon_cycle + 1
        sets.weapon.hist = {main=empty, sub=empty}
        if melee_weapon_cycle % melee_weapon_cycle_num == 0 then
            melee_weapon = 'tauret'
            sets.aftercast.melee = sets.aftercast.melee_atk
            set_weapon_by_sub_job(player.sub_job, melee_weapon)
            status_change(player.status)
            windower.add_to_chat(122,'---> トーレット')
        elseif melee_weapon_cycle % melee_weapon_cycle_num == melee_weapon_cycle_num - 1 then
            melee_weapon = 'd1'
            sets.aftercast.melee = sets.aftercast.melee_en
            set_weapon_by_sub_job(player.sub_job, melee_weapon)
            status_change(player.status)
            windower.add_to_chat(122,'---> D1')
        elseif melee_weapon_cycle % melee_weapon_cycle_num == melee_weapon_cycle_num - 2 then
            melee_weapon = 'crocea'
            sets.aftercast.melee = sets.aftercast.melee_atk
            set_weapon_by_sub_job(player.sub_job, melee_weapon)
            status_change(player.status)
            windower.add_to_chat(122,'---> クロセアモース')
        end
    elseif command ==  'ws' then
        melee_weapon = 'crocea'
        sets.aftercast.melee = sets.aftercast.melee_atk
        set_weapon_by_sub_job(player.sub_job, melee_weapon)
        status_change(player.status)
    elseif command == 'cure_self' then
        is_cure_self = not is_cure_self
        windower.add_to_chat(122,'---> 自己ケアル: '..tostring(is_cure_self))
    elseif command == 'dw' then
        is_dw = not is_dw
        windower.add_to_chat(122,'---> 二刀流+30: '..tostring(is_dw))
    elseif command == 'melee' then
        if is_dw then
            equip(sets.aftercast.melee, sets.aftercast.dw_30)
            windower.add_to_chat(122,'---> MELEE(二刀流+30)')
        else
            equip(sets.aftercast.melee)
            windower.add_to_chat(122,'---> MELEE')
        end
    elseif command == 'endmg' then
        sets.aftercast.melee = set_combine(sets.aftercast.melee, sets.aftercast.melee_en_dmg)
        status_change(player.status)
        windower.add_to_chat(122,'---> MELEE(魔法剣ダメージ+)')
    end
end
]]
function aftercast(spell, action)
	update_gear()
end

function status_change(new, action)
	update_gear()
end



function sub_job_change(new, old)
    
    if new ~= old then
        send_command('wait 1; input //gs c ws')
    end

end

