function get_sets()
    set_language('japanese')
    include('organizer-lib')
		
	Idle_Index = 1
	Buff_Index = 1
	Acc_Index = 1
	Armor_Index = 1
	Get_Index = 1
    TH_Index = 1
	Mode_Index = 1
	
--遠隔攻撃  レデンサリュート  ウィンドショット=Wind Shot  ウェポンスキル=Weapon Skill   ファントムロール=Phantom Roll  空蝉の術=utsusemi	
--JobAbility（ジョブアビリティ）
--WeaponSkill（ウェポンスキル）
--WhiteMagic（白魔法）
--BlackMagic（黒魔法）
--BlueMagic（青魔法）
--Ninjutsu（忍術）
--BardSong（歌）
--CorsairRoll（コルセアズロール）
--CorsairShot（クイックドロー）
--BloodPactRage（契約の履行:幻術）
--SummoningMagic（召喚魔法）
--PetCommand（ペットコマンド）
--Trust（フェイス）
 	Mode = {"Solo","Party"}
    
	sets.TH = {}
	--Treasure Hunter装备
	sets.TH['On'] = {}
	sets.TH['Off'] = {}
    sets.precast = {}
    sets.midcast = {}
	sets.precast.ws = {}	

		---- Job abilities ----
sets.precast['トリプルショット']  =  {body="ＣＳフラック+1",
							  back={ name="カムラスマント", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Snapshot"+10',}},}
sets.precast['ワイルドカード']  = {feet={ name="ＬＡブーツ+3", augments={'Enhances "Wild Card" effect',}},}
sets.precast['ランダムディール']  = {body={ name="ＬＡフラック+3", augments={'Enhances "Loaded Deck" effect',}},}
sets.precast['スネークアイ']    = {legs={ name="ＬＡトルーズ+3", augments={'Enhances "Snake Eye" effect',}},}
sets.precast['フォールド']     = {hands={ name="ＬＡガントリー+3", augments={'Enhances "Fold" effect',}},}
sets.precast['忍術']     = {neck="摩喉羅伽の数珠",body="パションジャケット",}
sets.precast['ダブルアップ']    = {right_ring="ルザフリング",}

sets.PhantomRoll = {
    head={ name="ＬＡトリコルヌ+3", augments={'Enhances "Winning Streak" effect',}},
    body={ name="ＬＡフラック+3", augments={'Enhances "Loaded Deck" effect',}},
    hands="ＣＳガントリー+1",
    legs={ name="ＬＡトルーズ+3", augments={'Enhances "Snake Eye" effect',}},
    feet={ name="ＬＡブーツ+3", augments={'Enhances "Wild Card" effect',}},
    neck="コモドアチャーム+2",
    waist="ウィンバフベルト+1",
    left_ear="テロスピアス",
    right_ear="エナベートピアス",
    left_ring="バラタリアリング",
    right_ring="ルザフリング",
    back={ name="カムラスマント", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}
	
	sets.PhantomRoll.Tactician = set_combine(sets.PhantomRoll, {body="ＣＳフラック+1"})
	sets.PhantomRoll.Allies = set_combine(sets.PhantomRoll, {})
	sets.PhantomRoll.Coursers = set_combine(sets.PhantomRoll, {})
	sets.PhantomRoll.Blitzer = set_combine(sets.PhantomRoll, {head="ＣＳトリコルヌ+1"})
	sets.PhantomRoll.Caster = set_combine(sets.PhantomRoll, {})
	
	
	--魔法增强有天气出现的装备
    sets.Obi = {}
    sets.Obi.Dark = {waist='八輪の帯',}
	
sets.precast.snap = {
    head={ name="テーオンシャポー", augments={'"Snapshot"+4','"Snapshot"+5',}},  --9
    body="ＬＫフラック+3",
    hands={ name="ＬＡガントリー+3", augments={'Enhances "Fold" effect',}},  --13
    legs="ＬＫトルーズ+3",  --15
    feet="メガナダジャンボ+2",  --10
    neck="コモドアチャーム+2",  --4
    waist="エスカンストーン",
    left_ear="テロスピアス",
    right_ear="エナベートピアス",
    left_ring="イラブラットリング",
    right_ring="アペートリング",
    back={ name="カムラスマント", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Snapshot"+10',}},
    }
	
sets.midcast.racc = {
    head="メガナダバイザー+2",
    body="ＬＫフラック+3",
    hands="メガナダグローブ+2",
    legs="アデマケックス+1",
    feet="メガナダジャンボ+2",
    neck="コモドアチャーム+2",
    waist="エスカンストーン",
    left_ear="テロスピアス",
    right_ear="エナベートピアス",
    left_ring="イラブラットリング",
    right_ring="アペートリング",
    back={ name="カムラスマント", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Snapshot"+10',}},
	}
	

sets.aftercast = {
    head={ name="アデマボンネット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="アデマジャケット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="カマインクウィス+1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="ヘルクリアブーツ", augments={'Accuracy+29','"Triple Atk."+4','Attack+3',}},
	neck="コモドアチャーム+2",
    --neck="黄昏の光輪",
    waist="霊亀腰帯",
    left_ear="テロスピアス",
    right_ear="セサンスピアス",
    left_ring="ヴォーケインリング",
    right_ring="守りの指輪",
    back={ name="カムラスマント", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}	

--站立
	sets.Idle = {
    head={ name="アデマボンネット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="アデマジャケット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="カマインクウィス+1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="ヘルクリアブーツ", augments={'Accuracy+29','"Triple Atk."+4','Attack+3',}},
    neck="コモドアチャーム+2",
    --neck="黄昏の光輪",
    waist="霊亀腰帯",
    left_ear="テロスピアス",
    right_ear="セサンスピアス",
    left_ring="ヴォーケインリング",
    right_ring="守りの指輪",
    back={ name="カムラスマント", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}

--拔刀	
sets.engaged = {
    head={ name="アデマボンネット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="アデマジャケット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="カマインクウィス+1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="ヘルクリアブーツ", augments={'Accuracy+29','"Triple Atk."+4','Attack+3',}},
	neck="コモドアチャーム+2",
    --neck="リソムネックレス",
    waist="霊亀腰帯",
    left_ear="テロスピアス",
    right_ear="セサンスピアス",
    left_ring="ペトロフリング",
    right_ring="アペートリング",
    back={ name="カムラスマント", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}		
	
	
        --WS装備
        -- 物理WS装備
    sets.precast.ws.phisical = {
	head={ name="ＬＡトリコルヌ+3", augments={'Enhances "Winning Streak" effect',}},
    body="ＬＫフラック+3",
    hands="メガナダグローブ+2",
--   legs={ name="ＬＡトルーズ+3", augments={'Enhances "Snake Eye" effect',}},
    legs={ name="ヘルクリアトラウザ", augments={'Rng.Atk.+29','Weapon skill damage +4%','AGI+6',}},
	feet={ name="ＬＡブーツ+3", augments={'Enhances "Wild Card" effect',}},
--    neck="コモドアチャーム+2",
--    waist="エスカンストーン",
    neck="フォシャゴルゲット",
    waist="フォシャベルト",
	left_ear="テロスピアス",
    right_ear={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
--    left_ring="ペトロフリング",
    left_ring="イラブラットリング",
	right_ring="ディンジルリング",
    back={ name="カムラスマント", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
    }
	
	sets.precast.ws.SavageBlade = {
	head={ name="ヘルクリアヘルム", augments={'Accuracy+10 Attack+10','Weapon skill damage +4%','STR+10','Accuracy+5',}},
	body="ＬＫフラック+3",
    hands="メガナダグローブ+2",
    legs={ name="ヘルクリアトラウザ", augments={'Attack+29','Weapon skill damage +4%','STR+8','Accuracy+5',}},
	feet={ name="ＬＡブーツ+3", augments={'Enhances "Wild Card" effect',}},
    neck="コモドアチャーム+2",
    waist="グルンフェルロープ",
    left_ear="テロスピアス",
    right_ear={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="イラブラットリング",
    right_ring="アペートリング",
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
        -- 魔法WS装備野火    
    sets.precast.ws.magicYH= {
	ammo="ライヴブレット",
	head={ name="ヘルクリアヘルム", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +3%','STR+1','"Mag.Atk.Bns."+12',}},
	body={ name="ＬＡフラック+3", augments={'Enhances "Loaded Deck" effect',}},
    hands={ name="カマインフィンガ+1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    --legs={ name="ヘルクリアトラウザ", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Crit.hit rate+2','INT+3','"Mag.Atk.Bns."+14',}},
    legs={ name="ヘルクリアトラウザ", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +3%','MND+2','"Mag.Atk.Bns."+15',}},
	feet={ name="ＬＡブーツ+3", augments={'Enhances "Wild Card" effect',}},
    neck="コモドアチャーム+2",
    waist="エスカンストーン",
    left_ear="フリオミシピアス",
    right_ear={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="イラブラットリング",
    right_ring="ディンジルリング",
    back={ name="カムラスマント", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
    }
	
    sets.precast.ws['イオリアンエッジ']  = sets.precast.ws.magicYH
    sets.precast.ws["ラストスタンド"] = sets.precast.ws.phisical
	sets.precast.ws["サベッジブレード"] = sets.precast.ws.SavageBlade
    sets.precast.ws["カラナック"] = sets.precast.ws.phisical
    sets.precast.ws["レデンサリュート"] = sets.precast.ws.magic
    sets.precast.ws["ワイルドファイア"] = sets.precast.ws.magicYH
end

-- 指定动作前装备的函数
function precast(spell)
    if spell.name == '飛び道具' then
        equip(sets.precast.snap) -- スナップショット快速射击装备
		
		elseif spell.name == "トリプルショット" then
		equip(sets.precast['トリプルショット'])
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
 
		elseif spell.type == "Ninjutsu" then --忍術(空蝉の術)
		equip(sets.precast['忍術'])
		send_command('@input /echo ---------N i n j u t s u---------') 
	
		elseif spell.type == 'WeaponSkill' then
        if sets.precast.ws[spell.name] then
            equip(sets.precast.ws[spell.name])
        else
            -- get_sets函数没定义的WS用物理WS装备
            equip(sets.precast.ws.phisical)		
        end
			elseif string.find(spell.english,'Shot') then
		    equip(sets.precast.ws.magicYH)
	
	    -- Job Abilities --
	elseif spell.type == 'JobAbility' then
	
	       -- Rolls --
    elseif spell.type == "CorsairRoll" or spell.japanese == "ダブルアップ" then
        if spell.japanese == "タクティックロール" then 
            equip(sets.PhantomRoll.Tactician)
        elseif spell.japanese == "キャスターズロール" then
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
        equip(sets.midcast.racc) -- 换成远准装备

    end

end	

  
  
function aftercast(spell,action)
    status_change(player.status)
  
end		

function status_change(new,tab,old)
    -- Idle --
    if new == 'Idle' then
	   
            equip(sets.Idle)
        
    -- Engaged --
    elseif new == 'Engaged' then
        equip(sets.engaged)
	
    end
	end
	
	
function self_command(command)
	if command == 'TH' then
		if TH_Index == 1 then 
		send_command('@input /echo ----- TH On -----')
		TH_Index = 2
		status_update()
		else
		send_command('@input /echo ----- TH Off -----')
		TH_Index = 1
		status_update()
		end
	elseif command == 'Mode' then
		Mode_Index = Mode_Index +1
		if Mode_Index > #Mode then Mode_Index = 1 end
		send_command('@input /echo ----- Current Mode: '..Mode[Mode_Index]..' -----')
		status_update()
	elseif command == 'acc' then
		Acc_Index = Acc_Index +1
		if Acc_Index > #Acc then Acc_Index = 1 end
		send_command('@input /echo ----- Current Accuracy: '..Acc[Acc_Index]..' -----')
		status_update()
	elseif command == 'MDT' then
		Armor_Index = 3
		send_command('@input /echo ----- MDT set -----')
		status_update()
	elseif command == 'PDT' then
		send_command('@input /echo ----- PDT set -----')
		Armor_Index = 2
		status_update()
	elseif command == 'TP' then
	    send_command('@input /echo ----- TP set -----')
		Armor_Index = 1
		status_update()
	elseif command == 'Eva' then
		send_command('@input /echo ----- Eva set -----')
		Armor_Index = 4
		status_update()

end	
	
end

function select_default_macro_book()
    if player.sub_job == 'DNC' then
        set_macro_page(1, 4)
    else
        set_macro_page(1, 4)
    end
end

function set_lockstyle()
    send_command('wait 4; input /lockstyleset 30' .. lockstyleset)
end