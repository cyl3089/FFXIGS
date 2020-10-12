require('GUI')
require('Modes')
function setup()
	AccuracyMode = M{['description']='Accuracy Mode', 'Normal', 'Mid', 'High'}
	
	WeaponMode = M{['description']='Weapon', 'repair','Rostam', 'Kaja Sword',}
	
	EngagedMode = M{['description']='Engaged Mode', 'Normal', 'Hybrid', 'DT'}
	IdleMode = M{['description']='Idle Mode', 'Normal', 'Meva', 'PDT'}
	
	Obi_WS = T{ -- Any weaponskills we want to check weather/day and use the obi
		--'Cloudsplitter',
	}
	
	WeaponTable = {
	    ['repair'] = {main="", type='Greatkatana', img='COR/repair.png'},
	    ['Rostam'] = {main="ロスタム", type='Greatkatana', img='COR/RostamA.png'},
		['Kaja Sword'] = {main="ネイグリング", type='Greatkatana', img='COR/Kaja Sword.png'}
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
--[[	
	Smertrios = {}
	Smertrios.Acc = {name="スメルトリオマント", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	Smertrios.WSD = {name="スメルトリオマント", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
		
	Valorous = {}
	Valorous.Head = {}
	Valorous.Head.WSD = { name="バロラスマスク", augments={'Accuracy+17 Attack+17','Weapon skill damage +8%','STR+15',}}
	Valorous.Head.Crit = { name="Valorous Mask", augments={'Accuracy+14','Crit. hit damage +4%','STR+13','Attack+4',}}
	Valorous.Body = {}
	Valorous.Body.STP = {name="Valorous Mail", augments={'INT+10','MND+4','"Store TP"+9','Mag. Acc.+1 "Mag.Atk.Bns."+1'}}
	Valorous.Body.MAB = {name="ファウンダブレスト", augments={'Accuracy+15','Mag. Acc.+15','Attack+15','"Mag.Atk.Bns."+15',}}
]]	

	sets.Obi = {waist="Hachirin-No-Obi"}
	
	sets.enmity = {
		head="Halitus Helm",
		body="Emet Harness +1",
		hands="Kurys Gloves",
		neck="Moonlight Necklace",
		waist="Kasiri Belt",
		ear1="Friomisi Earring",
		ear2="Cryptic Earring",
		ring1="Eihwaz Ring",
		ring2="Petrov Ring"
	}
	
	sets.precast = {}
	sets.midcast = {}
	sets.precast.ws = {}
	sets.JA = {}
sets.precast['ワイルドカード']  = {feet={ name="ＬＡブーツ+3", augments={'Enhances "Wild Card" effect',}},}
sets.precast['ランダムディール']  = {body={ name="ＬＡフラック+3", augments={'Enhances "Loaded Deck" effect',}},}
sets.precast['スネークアイ']    = {legs={ name="ＬＡトルーズ+3", augments={'Enhances "Snake Eye" effect',}},}
sets.precast['フォールド']     = {hands={ name="ＬＡガントリー+3", augments={'Enhances "Fold" effect',}},}
sets.precast['忍術']     = {neck="摩喉羅伽の数珠",
                           body="パションジャケット",
						   left_ear="ハラサズピアス",
						   right_ring="エバネセンスリング",
						   legs={ name="カマインクウィス+1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},}
sets.precast['ダブルアップ']    = {right_ring="ルザフリング",}

	sets.idle = {}
	sets.idle.Normal = {
    head={ name="アデマボンネット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="アデマジャケット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="カマインクウィス+1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="ヘルクリアブーツ", augments={'Accuracy+29','"Triple Atk."+4','Attack+3',}},
    neck="コモドアチャーム+2",
    --neck="黄昏の光輪",
    waist={ name="セールフィベルト+1", augments={'Path: A',}},
    left_ear="テロスピアス",
    right_ear="セサンスピアス",
    left_ring="ゼラチナスリング+1",
    right_ring="守りの指輪",
    back={ name="カムラスマント", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}
	sets.idle['Meva'] = set_combine(sets.idle.Normal, { 
--    sets.idle.HybridDT = {
    head="メガナダバイザー+2",
    body="マリグナスタバード",
    hands="マリグナスグローブ",
    legs="マリグナスタイツ",
    feet="マリグナスブーツ",
    neck="ロリケートトルク+1",
    left_ear="エテオレートピアス",
    right_ear={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
    back={ name="カムラスマント", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}	)

	sets.idle['PDT'] = set_combine(sets.idle.Normal, { 
--    sets.idle.HybridDT = {
    head="メガナダバイザー+2",
    body="マリグナスタバード",
    hands="マリグナスグローブ",
    feet="マリグナスブーツ",
    neck="ロリケートトルク+1",
    back={ name="カムラスマント", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}	)
	

	
sets.engaged = {
    head={ name="アデマボンネット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="アデマジャケット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="メガナダショウス+2",
    feet={ name="ヘルクリアブーツ", augments={'Accuracy+29','"Triple Atk."+4','Attack+3',}},
    neck="リソムネックレス",
    waist={ name="セールフィベルト+1", augments={'Path: A',}},
    left_ear="テロスピアス",
    right_ear="セサンスピアス",
    left_ring="エポナリング",
    right_ring="ヘタイロイリング",
    back={ name="カムラスマント", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}

	sets.engaged.Mid = set_combine(sets.engaged, {
		body="ＬＡフラック+3",
	})
	
	sets.engaged.High = set_combine(sets.engaged.Mid, {
		ring2="王将の指輪" --"Regal Ring"
	})
	
	sets.engaged.Hybrid = {
    head={ name="アデマボンネット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="アデマジャケット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="カマインクウィス+1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="ヘルクリアブーツ", augments={'Accuracy+29','"Triple Atk."+4','Attack+3',}},
--    neck="コモドアチャーム+2",
    neck="ロリケートトルク+1",
    waist={ name="セールフィベルト+1", augments={'Path: A',}},
    left_ear="テロスピアス",
    right_ear="セサンスピアス",
    left_ring="ゼラチナスリング+1",
    right_ring="守りの指輪",
    back={ name="カムラスマント", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }	

	sets.engaged.DT = {
    head="メガナダバイザー+2",
    body="マリグナスタバード",
    hands="マリグナスグローブ",
    legs="マリグナスタイツ",
    feet="マリグナスブーツ",
    neck="ロリケートトルク+1",
    waist={ name="セールフィベルト+1", augments={'Path: A',}},
    left_ear="エテオレートピアス",
    right_ear={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="ゼラチナスリング+1",
    right_ring="守りの指輪",
    back={ name="カムラスマント", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}	
	
	
	
	sets.precast.CorsairShot = {}
	
    sets.midcast.CorsairShot = {
        ammo="ライヴブレット",
        head={ name="ヘルクリアヘルム", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +3%','STR+1','"Mag.Atk.Bns."+12',}},
        body={ name="ＬＡフラック+3", augments={'Enhances "Loaded Deck" effect',}},
        hands={ name="カマインフィンガ+1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
        --legs={ name="ヘルクリアトラウザ", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Crit.hit rate+2','INT+3','"Mag.Atk.Bns."+14',}},
        legs={ name="ヘルクリアトラウザ", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +3%','MND+2','"Mag.Atk.Bns."+15',}},
        feet={ name="ＬＡブーツ+3", augments={'Enhances "Wild Card" effect',}},
 --     neck="コモドアチャーム+2",
        neck="ベーテルペンダント",
        waist="エスカンストーン",
        left_ear="フリオミシピアス",
        right_ear={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
        left_ring="アルビナリング+1",
        right_ring="ディンジルリング",
        back={ name="カムラスマント", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
    }

    sets.midcast.CorsairShot.Acc = {
        ammo="ライヴブレット",
        head="ムンムボンネット+2",
        body="オショシベスト+1",
        hands="ムンムリスト+2",
        legs="ムンムケックス+2",
        feet="ムンムゲマッシュ+2",
        neck="コモドアチャーム+2",
        waist="カフカチナベルト+1",  
        left_ear="ハメティックピアス",  --有 
        right_ear="ディグニタリピアス",
        left_ring="キシャールリング",
        right_ring="アルビナリング+1",
        back={ name="カムラスマント", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
    }

    sets.midcast.CorsairShotL = {
        ammo="ライヴブレット",
        head="ムンムボンネット+2",
        body="オショシベスト+1",
        hands="マリグナスグローブ",
        legs="マリグナスタイツ",
        feet="マリグナスブーツ",
        neck="コモドアチャーム+2",
        waist="カフカチナベルト+1",
        left_ear="ハメティックピアス",   --有
        right_ear="ディグニタリピアス",
        left_ring="キシャールリング",
        right_ring="ムンムリング",  --没有，所以先用这个
        --    right_ring="スティキニリング+1",  --没有
        back={ name="カムラスマント", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
	}


	
sets.PhantomRoll = {
    head={ name="ＬＡトリコルヌ+3", augments={'Enhances "Winning Streak" effect',}},
    body={ name="ＬＡフラック+3", augments={'Enhances "Loaded Deck" effect',}},
    hands="ＣＳガントリー+1",
    legs={ name="ＬＡトルーズ+3", augments={'Enhances "Snake Eye" effect',}},
    feet={ name="ＬＡブーツ+3", augments={'Enhances "Wild Card" effect',}},
    neck="王将の首飾り",
    waist={ name="セールフィベルト+1", augments={'Path: A',}},
    left_ear="テロスピアス",
    right_ear="エナベートピアス",
    left_ring="バラタリアリング",
    right_ring="ルザフリング",
    back={ name="カムラスマント", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}
	
	sets.PhantomRoll.Tactician = set_combine(sets.PhantomRoll, {body="ＣＳフラック+1"})
	sets.PhantomRoll.Allies = set_combine(sets.PhantomRoll, {hands="ＣＳガントリー+1"})
	sets.PhantomRoll.Coursers = set_combine(sets.PhantomRoll, {feet="ＣＳブーツ+1"})
	sets.PhantomRoll.Blitzer = set_combine(sets.PhantomRoll, {head="ＣＳトリコルヌ+1"})
	sets.PhantomRoll.Caster = set_combine(sets.PhantomRoll, {})
	
	
	--魔法增强有天气出现的装备
    sets.Obi = {}
    sets.Obi.Dark = {waist='八輪の帯',}

sets.TripleShot =  {
    head="オショシマスク+1",
    body="ＣＳフラック+1",
    hands={ name="ＬＡガントリー+3", augments={'Enhances "Fold" effect',}},
    legs="オショシトラウザ+1",
    feet="オショシレギンス+1",
    neck="コモドアチャーム+2",
    --没有   neck="イスクルゴルゲット",
    waist="カフカチナベルト+1",
    left_ear="テロスピアス",
    right_ear="エナベートピアス",
    left_ring="イラブラットリング",
    right_ring="ムンムリング",
 -- left_ring="スティキニリング+1",  --没有
--没有    right_ring="Hajduk Ring",
	back={ name="カムラスマント", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Snapshot"+10',}},}

sets.midcast.TripleShot	=  {
    head="オショシマスク+1",
    body="オショシベスト+1",
    hands={ name="ＬＡガントリー+3", augments={'Enhances "Fold" effect',}},
    legs="オショシトラウザ+1",
    feet="オショシレギンス+1",
--    neck="コモドアチャーム+2",
    neck="イスクルゴルゲット",
    waist="カフカチナベルト+1",
    left_ear="テロスピアス",
    right_ear="エナベートピアス",
    left_ring="イラブラットリング",
    right_ring="王将の指輪",
 -- left_ring="スティキニリング+1",  --没有
--没有    right_ring="Hajduk Ring",
	back={ name="カムラスマント", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Snapshot"+10',}},}

	
	
	
sets.precast.RA = {
    ammo="クロノブレット",
    head={ name="テーオンシャポー", augments={'Rng.Acc.+25','"Snapshot"+4','"Snapshot"+5',}},  --9
    body="オショシベスト+1",  --14
    hands={ name="ＬＡガントリー+3", augments={'Enhances "Fold" effect',}},  --13
    legs="ＬＫトルーズ+3",  --15
    feet="メガナダジャンボ+2",  --10
    neck="コモドアチャーム+2",  --4
    waist="インパルスベルト",  --3
    left_ear="テロスピアス",
    right_ear="エナベートピアス",
    left_ring="イラブラットリング",
    right_ring="アペートリング",
    back={ name="カムラスマント", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Snapshot"+10',}},  --10
    }

    -- Ranged gear
    sets.midcast.RA = {
    ammo="クロノブレット",
    head="メガナダバイザー+2",
    body="オショシベスト+1",
    hands="マリグナスグローブ",
    legs="マリグナスタイツ",
    feet="マリグナスブーツ",
    neck="イスクルゴルゲット",
--    neck="コモドアチャーム+2",
    waist="カフカチナベルト+1",
    left_ear="テロスピアス",
    right_ear="エナベートピアス",
    left_ring="イラブラットリング",
    right_ring="ラジャスリング",
    back={ name="カムラスマント", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
	}

	
    sets.midcast.RA.Acc = {
    range={ name="デスペナルティ", augments={'Path: A',}},
    ammo="クロノブレット",
    head="メガナダバイザー+2",
    body="マリグナスタバード",
    hands="マリグナスグローブ",
    legs="マリグナスタイツ",
    feet="マリグナスブーツ",
    neck="イスクルゴルゲット",
	--    neck={ name="コモドアチャーム+2", augments={'Path: A',}},
    waist="カフカチナベルト+1",
    left_ear="テロスピアス",
    right_ear="エナベートピアス",
    left_ring="イラブラットリング",
    right_ring="王将の指輪",
    back={ name="カムラスマント", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
	}
	

sets.aftercast = {
    head={ name="アデマボンネット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="アデマジャケット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="カマインクウィス+1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="ヘルクリアブーツ", augments={'Accuracy+29','"Triple Atk."+4','Attack+3',}},
	neck="コモドアチャーム+2",
    --neck="黄昏の光輪",
    waist={ name="セールフィベルト+1", augments={'Path: A',}},
    left_ear="テロスピアス",
    right_ear="セサンスピアス",
    left_ring="ゼラチナスリング+1",
    right_ring="守りの指輪",
    back={ name="カムラスマント", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}	

	        --WS装備
        -- 物理WS装備
    sets.precast.ws.phisical = {
    ammo="クロノブレット",
    head={ name="ＬＡトリコルヌ+3", augments={'Enhances "Winning Streak" effect',}},
    body="ＬＫフラック+3",
    hands="メガナダグローブ+2",
    legs={ name="ヘルクリアトラウザ", augments={'Attack+24','Weapon skill damage +5%','AGI+3','Rng.Acc.+4','Rng.Atk.+14',}},
    feet={ name="ＬＡブーツ+3", augments={'Enhances "Wild Card" effect',}},
    neck="フォシャゴルゲット",
    waist="フォシャベルト",
    left_ear="イシュヴァラピアス",
    right_ear={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="ＫＲリング+1",
    right_ring="王将の指輪",
    back={ name="カムラスマント", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
}

    sets.precast.ws.Evisceration = {
    head={ name="アデマボンネット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body="アブノーバカフタン",
    hands="ムンムリスト+2",
    legs={ name="サムヌータイツ", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="ヘルクリアブーツ", augments={'Crit. hit damage +4%','DEX+15','Attack+8',}},
    neck="フォシャゴルゲット",
    waist="フォシャベルト",
    left_ear="マーケピアス+1",
    right_ear={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="イラブラットリング",
    right_ring="王将の指輪",
    back={ name="カムラスマント", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}
	
	sets.precast.ws.SavageBlade = {
    head={ name="ヘルクリアヘルム", augments={'Accuracy+10 Attack+10','Weapon skill damage +4%','STR+10','Accuracy+5',}},
    body="ＬＫフラック+3",
    hands="メガナダグローブ+2",
    legs={ name="ヘルクリアトラウザ", augments={'Attack+29','Weapon skill damage +4%','STR+8','Accuracy+5',}},
    feet={ name="ＬＡブーツ+3", augments={'Enhances "Wild Card" effect',}},
    neck={ name="コモドアチャーム+2", augments={'Path: A',}},
    waist={ name="セールフィベルト+1", augments={'Path: A',}},
    left_ear="イシュヴァラピアス",
    right_ear={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="ＫＲリング+1",
    right_ring="王将の指輪",
    back={ name="カムラスマント", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}
	
        -- 魔法WS装備    
    sets.precast.ws.magic= {
	ammo="ライヴブレット",
	head="妖蟲の髪飾り+1",
    body={ name="ＬＡフラック+3", augments={'Enhances "Loaded Deck" effect',}},
    hands={ name="カマインフィンガ+1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs={ name="ヘルクリアトラウザ", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +3%','MND+2','"Mag.Atk.Bns."+15',}},
	feet={ name="ＬＡブーツ+3", augments={'Enhances "Wild Card" effect',}},
    neck="コモドアチャーム+2",
    waist="スヴェルグーリズ+1",
    left_ear="フリオミシピアス",
    right_ear={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="アルコンリング",
    right_ring="ディンジルリング",
    back={ name="カムラスマント", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
    }
	
	sets.precast.ws.magic15= {
	ammo="ライヴブレット",
	head="妖蟲の髪飾り+1",
    body={ name="ＬＡフラック+3", augments={'Enhances "Loaded Deck" effect',}},
    hands={ name="カマインフィンガ+1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs={ name="ヘルクリアトラウザ", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +3%','MND+2','"Mag.Atk.Bns."+15',}},
	feet={ name="ＬＡブーツ+3", augments={'Enhances "Wild Card" effect',}},
    neck="コモドアチャーム+2",
    waist="オルペウスサッシュ",
    left_ear="フリオミシピアス",
    right_ear={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="アルコンリング",
    right_ring="ディンジルリング",
    back={ name="カムラスマント", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
    }
	
	
	
        -- 魔法WS装備野火    
    sets.precast.ws.magicYH= {
	ammo="ライヴブレット",
    head={ name="ヘルクリアヘルム", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +3%','STR+1','"Mag.Atk.Bns."+12',}},
    body={ name="ＬＡフラック+3", augments={'Enhances "Loaded Deck" effect',}},
    hands={ name="カマインフィンガ+1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs={ name="ヘルクリアトラウザ", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +3%','MND+2','"Mag.Atk.Bns."+15',}},
    feet={ name="ＬＡブーツ+3", augments={'Enhances "Wild Card" effect',}},
    neck="コモドアチャーム+2",
    waist="オルペウスサッシュ",
    left_ear="フリオミシピアス",
    right_ear={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="アルビナリング+1",
    right_ring="ディンジルリング",
    back={ name="カムラスマント", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
}
	
    sets.precast.ws['イオリアンエッジ']  = sets.precast.ws.magicYH
	sets.precast.ws["ワイルドファイア"] = sets.precast.ws.magicYH
	sets.precast.ws["ホットショット"] = sets.precast.ws.magicYH
    sets.precast.ws["ラストスタンド"] = sets.precast.ws.phisical
	sets.precast.ws["エヴィサレーション"] = sets.precast.ws.Evisceration
	sets.precast.ws["サベッジブレード"] = sets.precast.ws.SavageBlade
    sets.precast.ws["カラナック"] = sets.precast.ws.phisical
    sets.precast.ws["レデンサリュート"] = sets.precast.ws.magic
    sets.precast.ws["エクゼンテレター"] = sets.precast.ws.phisical
    sets.precast.ws["レクイエスカット"] = sets.precast.ws.Evisceration
	sets.precast.ws["スプリットショット"] = sets.precast.ws.phisical	
end

send_command('input /macro book 4;wait .1;input /macro set 3;wait 1;input /lockstyleset 30')



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

slotmap = T{'sub','range','ammo','head','body','hands','legs','feet','neck','waist',
    'left_ear', 'right_ear', 'left_ring', 'right_ring','back','ear1','ear2','ring1','ring2'}
	
function emptyset(set)
	for k, v in pairs(set) do
		if slotmap:contains(k) then
			return false
		end		
	end
	return true
end


function aftercast(spell, action)
	update_gear()
end

function status_change(new, action)
	update_gear()
end

function buff_change(buff, gain)
	if T{'Blindness', 'Flash', 'Aftermath', 'Aftermath: Lv.3'}:contains(buff) then -- only update if it's a buff that affects engaged/idle choices
		update_gear()
	end
end

-- 指定动作前装备的函数
function precast(spell)
    if spell.name == '飛び道具' then
        equip(sets.precast.RA) -- スナップショット快速射击装备
		
    elseif ((spell.name == 'レデンサリュート') and (player.target.distance    <= 7.0)) then  --15米以内换的装备主要是腰带
        equip(sets.precast.ws.magic15)

		
		elseif spell.name == "トリプルショット" then
		equip(sets.TripleShot)
		send_command('@input /echo ---------Triple Shot---------')
		
		
		elseif spell.name == "ダブルアップ" then
		equip(sets.precast['ダブルアップ'])
		send_command('@input /echo Double-Up')
		
		elseif spell.name == "ワイルドカード" then
		equip(sets.precast['ワイルドカード'])
		send_command('@input /echo ---------SP---SP---SP---SP---------')

		elseif spell.name == "ランダムディール" then
		equip(sets.precast['ランダムディール'])
		send_command('@input /echo ---------Random Deal---------')
		
		elseif spell.name == "スネークアイ" then
		equip(sets.precast['スネークアイ'])
		send_command('@input /echo ---------Snake Eye---------')
		
		elseif spell.name == "フォールド" then
		equip(sets.precast['フォールド'])
		send_command('@input /echo ---------Fold---------')
 
--		elseif spell.type == "Ninjutsu" then --忍術(空蝉の術)
	    elseif spell.action_type=='Magic' then
		equip(sets.precast['忍術'])
		send_command('@input /echo ---------N i n j u t s u---------') 
	
		elseif spell.type == 'WeaponSkill' then
        if sets.precast.ws[spell.name] then
            equip(sets.precast.ws[spell.name])
        else
            -- get_sets函数没定义的WS用物理WS装备
            equip(sets.precast.ws.phisical)		
        end
		
			elseif spell.name == "ライトショット" or spell.name == "ダークショット" then
			equip(sets.midcast.CorsairShotL)
			
			elseif string.find(spell.english,'Shot') then
		    equip(sets.midcast.CorsairShot)


	    -- Job Abilities --
	elseif spell.type == 'JobAbility' then
	
	       -- Rolls --
    elseif spell.type == "CorsairRoll" or spell.japanese == "ダブルアップ" then
        if spell.japanese == "タクティックロール" then 
            equip(sets.PhantomRoll.Tactician)
        elseif spell.japanese == "キャスターズロール" then  --触发位置没有加入装备,因为没有做这个裤子
            equip(sets.PhantomRoll.Caster)
        elseif spell.japanese == "コアサーズロール" then
            equip(sets.PhantomRoll.Courser)
        elseif spell.japanese == "ブリッツァロール" then
            equip(sets.PhantomRoll.Blitzer)
        elseif spell.japanese == "アライズロール" then
            equip(sets.PhantomRoll.Allies)
		else
            equip(sets.PhantomRoll)
		end		
		
	end	
    end

-- 指定动作前装备的函数
function midcast(spell)
    if spell.name == '飛び道具' then
        equip(sets.midcast.RA.Acc) -- 换成远准装备
        if buffactive['トリプルショット'] then
             equip(sets.midcast.TripleShot)
			 end
    end

end	

function job_buff_change(buff, gain)
    if buffactive[467] then
        equip(sets.midcast.TripleShot)
        handle_equipping_gear(player.status)
    else
                equip(sets.midcast.RA)
        handle_equipping_gear(player.status)
    end
end
  
  
function aftercast(spell,action)
    status_change(player.status)
  
end		
--[[
function status_change(new,tab,old)
    -- Idle --
    if new == 'Idle' then
	   
            equip(sets.idle)
        
    -- Engaged --
    elseif new == 'Engaged' then
        equip(sets.engaged)
	
    end
	end
]]	

windower.raw_register_event('prerender', 
	function()
		local t = windower.ffxi.get_mob_by_target('t')    --不使用rnghelper.lua不能使用 local t = ft_target()
		if t and bit.band(t.id,0xFF000000) ~= 0 then -- highest byte of target.id indicates whether it's a player or not
			facetarget()
		end
	end)

function facetarget()
    local player = windower.ffxi.get_player()
    if player.status == 1 then return end
    local t = windower.ffxi.get_mob_by_target('t')      --不使用rnghelper.lua不能使用 local t = ft_target()
    windower.ffxi.turn(
        math.atan2(
            t.x - windower.ffxi.get_mob_by_id(player.id).x,
            t.y - windower.ffxi.get_mob_by_id(player.id).y
        ) - 1.5708
    )
end
