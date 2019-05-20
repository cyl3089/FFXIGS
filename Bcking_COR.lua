-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    gs c toggle LuzafRing -- Toggles use of Luzaf Ring on and off
    
    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.
    
    Weaponskill mode, if set to 'Normal', is handled separately for melee and ranged weaponskills.
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    set_language('japanese')
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	-- Whether to use ルザフリング
    state.LuzafRing = M(false, "ルザフリング")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    define_roll_values()

	
end

function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
    add_to_chat (21, 'Lockstyle Set!')
    add_to_chat (55, 'You are on '..('Cor '):color(5)..''..(''):color(55)..''..('Macros set!'):color(121))
end
set_style(30)
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Melee', 'HybridDT', 'Ranged', 'Acc')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'LowAcc', 'HighAcc', 'WildfireWeather', 'LeadanWeather')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('PDT')

--    gear.RAbullet = "Chrono Bullet"
--    gear.WSbullet = "Chrono Bullet"
	gear.RAbullet = "ライヴブレット"
    gear.WSbullet = "ライヴブレット"
    gear.MAbullet = "ライヴブレット"
    options.ammo_warning_limit = 15

    -- Additional local binds
--    send_command('bind ^` input /ja "Double-up" <me>')
    send_command('bind ^` input /ja ダブルアップ <me>')
    send_command('bind !` gs equip sets.engaged.TH')
	send_command('bind f10 gs c cycle RangedMode')
	send_command('bind f11 gs c cycle WeaponskillMode')
	send_command('bind numpad0 input /ra <t>')
	send_command('bind !w input /equip ring2 "Warp Ring"; /echo Warping; wait 11; input /item "Warp Ring" <me>;')
    send_command('bind !q input /equip ring2 "Dim. Ring (Holla)"; /echo Reisenjima; wait 11; input /item "Dim. Ring (Holla)" <me>;')
	send_command('bind !e input /item やまびこ薬 <me>')
	send_command('bind !h input /item 聖水 <me>')

    select_default_macro_book()

end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind !w')
    send_command('unbind !`')
	send_command('unbind ^`')
	send_command('unbind !q')
	send_command('unbind !e')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets

    -- Precast sets to enhance JAs
    
    sets.precast.JA['Triple Shot'] = {body="ＣＳフラック+1"}
    sets.precast.JA['Snake Eye']    = {legs={ name="ＬＡトルーズ+3", augments={'Enhances "Snake Eye" effect',}},}
    sets.precast.JA['Wild Card']  = {feet={ name="ＬＡブーツ+3", augments={'Enhances "Wild Card" effect',}},}
    sets.precast.JA['Random Deal']  = {body={ name="ＬＡフラック+3", augments={'Enhances "Loaded Deck" effect',}},}
	sets.precast.JA['Fold']     = {hands={ name="ＬＡガントリー+3", augments={'Enhances "Fold" effect',}},}
	sets.precast.JA['Double-Up']    = {right_ring="ルザフリング",}
--	sets.TreasureHunter = {body={ name="Herculean Vest", augments={'VIT+1','Pet: AGI+9','"Treasure Hunter"+2','Accuracy+12 Attack+12','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
--	hands={ name="Herculean Gloves", augments={'DEX+5','"Fast Cast"+3','"Treasure Hunter"+2',}}, waist="Chaac Belt",}
    
    sets.precast.CorsairRoll = {
	head={ name="ＬＡトリコルヌ+3", augments={'Enhances "Winning Streak" effect',}},
    body={ name="ＬＡフラック+3", augments={'Enhances "Loaded Deck" effect',}},
    hands="ＣＳガントリー+1",
    feet="ＣＳブーツ+1",
    left_ring="バラタリアリング",	
    right_ring="ルザフリング",
	neck="王将の首飾り",
    back={ name="カムラスマント", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},}
    
    sets.precast.CorsairRoll["キャスターズロール"] = set_combine(sets.precast.CorsairRoll, {head={ name="ＬＡトリコルヌ+3", augments={'Enhances "Winning Streak" effect',}},
	hands="ＣＳガントリー+1",neck="王将の首飾り",ring2="ルザフリング"})
    
	sets.precast.CorsairRoll["コアサーズロール"] = set_combine(sets.precast.CorsairRoll, {head={ name="ＬＡトリコルヌ+3", augments={'Enhances "Winning Streak" effect',}},
	hands="ＣＳガントリー+1",neck="王将の首飾り",ring2="ルザフリング"})    

	sets.precast.CorsairRoll["ブリッツァロール"] = set_combine(sets.precast.CorsairRoll, {head={ name="ＬＡトリコルヌ+3", augments={'Enhances "Winning Streak" effect',}},
	hands="ＣＳガントリー+1",neck="王将の首飾り",ring2="ルザフリング"})
    
	sets.precast.CorsairRoll["タクティックロール"] = set_combine(sets.precast.CorsairRoll, {head={ name="ＬＡトリコルヌ+3", augments={'Enhances "Winning Streak" effect',}},
	hands="ＣＳガントリー+1",neck="王将の首飾り",ring2="ルザフリング"})
    
	sets.precast.CorsairRoll["アライズロール"] = set_combine(sets.precast.CorsairRoll, {head={ name="ＬＡトリコルヌ+3", augments={'Enhances "Winning Streak" effect',}},
	hands="ＣＳガントリー+1",neck="王将の首飾り",ring2="ルザフリング"})
    
--    sets.precast.LuzafRing = {ring2="ルザフリング"}
--    sets.precast.FoldDoubleBust = {hands={ name="ＬＡガントリー+3", augments={'Enhances "Fold" effect',}}}
    
    sets.precast.CorsairShot = {}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['ヒーリングワルツ'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
--	    head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
--		body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
 --       neck="Orunmila's Torque",
 -- 		left_ear="エテオレートピアス",
 --       right_ear="Loquac. Earring",
 --       left_ring="Kishar Ring",
    right_ring="プロリクスリング",
 -- 		legs={ name="Rawhide Trousers", augments={'MP+50','"Fast Cast"+5','"Refresh"+1',}},
    feet="カマイングリーヴ+1",
	hands={ name="レイライングローブ", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
--		back="Moonlight Cape",}
   }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="摩喉羅伽の数珠",
	                                                         body="パションジャケット",
															 left_ear="ハラサズピアス",
															 right_ring="エバネセンスリング",
															 
						                                     legs={ name="カマインクウィス+1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},})

    --71% Snapshot with 10% Job gift. Cap is 70%
    sets.precast.RA = {ammo=gear.RAbullet,
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

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
    ammo=gear.WSbullet,
	head={ name="ヘルクリアヘルム", augments={'Accuracy+10 Attack+10','Weapon skill damage +4%','STR+10','Accuracy+5',}},
	body="ＬＫフラック+3",
    hands="メガナダグローブ+2",
    legs={ name="ヘルクリアトラウザ", augments={'Attack+29','Weapon skill damage +4%','STR+8','Accuracy+5',}},
	feet={ name="ＬＡブーツ+3", augments={'Enhances "Wild Card" effect',}},
    neck="コモドアチャーム+2",
    waist="グルンフェルロープ",
    left_ear="イシュヴァラピアス",
    right_ear={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="イラブラットリング",
    right_ring="アペートリング",
    back={ name="カムラスマント", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    }


    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Savage Blade'] = {
	ammo=gear.WSbullet,	
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
	
    sets.precast.WS['Evisceration'] = {
	ammo="ライヴブレット",
	head="ムンムボンネット+1",
    body="ムンムジャケット+2",
    hands="ムンムリスト+1",
    legs="ムンムケックス+2",
    feet="ムンムゲマッシュ+2",
    neck="フォシャゴルゲット",
    waist="フォシャベルト",
    left_ear="マーケピアス+1",
    right_ear="マーケピアス+1",
    left_ring="イラブラットリング",
    right_ring="ムンムリング",
    back={ name="カムラスマント", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}, --这个要换成爆击的
    }
	
	
	
	
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Aeolian Edge'] = {
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
	  
	  

    sets.precast.WS['Last Stand'] = {
	ammo=gear.WSbullet,
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
	left_ear="イシュヴァラピアス",
    right_ear={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
--    left_ring="ペトロフリング",
    left_ring="イラブラットリング",
	right_ring="ディンジルリング",
    back={ name="カムラスマント", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
    }
	
	sets.precast.WS['Last Stand'].LowAcc = {
	ammo=gear.WSbullet,
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
	left_ear="イシュヴァラピアス",
    right_ear={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
--    left_ring="ペトロフリング",
    left_ring="イラブラットリング",
	right_ring="ディンジルリング",
    back={ name="カムラスマント", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
    }

    sets.precast.WS['Last Stand'].HighAcc = {
	ammo=gear.WSbullet,
    head={ name="ＬＡトリコルヌ+3", augments={'Enhances "Winning Streak" effect',}},
    body="ＬＫフラック+3",
    hands="メガナダグローブ+2",
    legs={ name="ヘルクリアトラウザ", augments={'Rng.Atk.+29','Weapon skill damage +4%','AGI+6',}},
	feet="メガナダジャンボ+2",
    neck="フォシャゴルゲット",
    waist="フォシャベルト",
	left_ear="イシュヴァラピアス",
    right_ear={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="イラブラットリング",
	right_ring="ディンジルリング",
    back={ name="カムラスマント", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
    }

   sets.precast.WS['Hot Shot'] = {
	ammo=gear.MAbullet,
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
	
	
    sets.precast.WS['Wildfire'] = {
	ammo=gear.MAbullet,
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
	
	sets.precast.WS['Wildfire'].WildfireWeather = {
	ammo=gear.MAbullet,
	head={ name="ヘルクリアヘルム", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +3%','STR+1','"Mag.Atk.Bns."+12',}},
	body={ name="ＬＡフラック+3", augments={'Enhances "Loaded Deck" effect',}},
    hands={ name="カマインフィンガ+1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    --legs={ name="ヘルクリアトラウザ", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Crit.hit rate+2','INT+3','"Mag.Atk.Bns."+14',}},
    legs={ name="ヘルクリアトラウザ", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +3%','MND+2','"Mag.Atk.Bns."+15',}},
	feet={ name="ＬＡブーツ+3", augments={'Enhances "Wild Card" effect',}},
    neck="コモドアチャーム+2",
    waist="八輪の帯",
    left_ear="ヘカテーピアス",
    right_ear="フリオミシピアス",
    right_ring="ディンジルリング",
    left_ring="カリエイリング",
     back={ name="カムラスマント", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
    }

    sets.precast.WS['Wildfire'].Brew = {
	ammo=gear.MAbullet,
	head={ name="ヘルクリアヘルム", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +3%','STR+1','"Mag.Atk.Bns."+12',}},
	body={ name="ＬＡフラック+3", augments={'Enhances "Loaded Deck" effect',}},
    hands={ name="カマインフィンガ+1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    --legs={ name="ヘルクリアトラウザ", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Crit.hit rate+2','INT+3','"Mag.Atk.Bns."+14',}},
    legs={ name="ヘルクリアトラウザ", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +3%','MND+2','"Mag.Atk.Bns."+15',}},
	feet={ name="ＬＡブーツ+3", augments={'Enhances "Wild Card" effect',}},
    neck="コモドアチャーム+2",
    waist="エスカンストーン",
    left_ear="ヘカテーピアス",
    right_ear="フリオミシピアス",
    right_ring="ディンジルリング",
    left_ring="カリエイリング",
     back={ name="カムラスマント", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
    }
    
    sets.precast.WS['Leaden Salute'] = {
	ammo=gear.MAbullet,
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
	
	sets.precast.WS['Leaden Salute'].LeadanWeather = {
	ammo=gear.MAbullet,
	head="妖蟲の髪飾り+1",
    body={ name="ＬＡフラック+3", augments={'Enhances "Loaded Deck" effect',}},
    hands={ name="カマインフィンガ+1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs={ name="ヘルクリアトラウザ", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +3%','MND+2','"Mag.Atk.Bns."+15',}},
	feet={ name="ＬＡブーツ+3", augments={'Enhances "Wild Card" effect',}},
    neck="コモドアチャーム+2",
    waist="八輪の帯",  --没有
    left_ear="フリオミシピアス",
    right_ear={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="アルコンリング",
    right_ring="ディンジルリング",
    back={ name="カムラスマント", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
    }
	
    
    
    -- Midcast Sets
    sets.midcast.FastRecast = {}
        
    -- Specific spells
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    sets.midcast.CorsairShot = {
	ammo="ライヴブレット",
	head={ name="ヘルクリアヘルム", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +3%','STR+1','"Mag.Atk.Bns."+12',}},
	body={ name="ＬＡフラック+3", augments={'Enhances "Loaded Deck" effect',}},
    hands={ name="カマインフィンガ+1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    --legs={ name="ヘルクリアトラウザ", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Crit.hit rate+2','INT+3','"Mag.Atk.Bns."+14',}},
    legs={ name="ヘルクリアトラウザ", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +3%','MND+2','"Mag.Atk.Bns."+15',}},
	feet={ name="ＬＡブーツ+3", augments={'Enhances "Wild Card" effect',}},
    neck="コモドアチャーム+2",
--这里与野火不同,没有先用+2项链  neck="ベーテルペンダント",
    waist="エスカンストーン",
    left_ear="フリオミシピアス",
    right_ear={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="アルビナリング+1",
    right_ring="ディンジルリング",
    back={ name="カムラスマント", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
    }

    sets.midcast.CorsairShot.Acc = {
	ammo="ライヴブレット",
	head="ムンムボンネット+1",
    body="オショシベスト+1",
    hands="ムンムリスト+1",
    legs="ムンムケックス+2",
    feet="ムンムゲマッシュ+2",
    neck="コモドアチャーム+2",
    waist="カフカチナベルト",  --这里换成+1
    left_ear="ハメティックピアス",  --没有 ギアスフェットNM「Alpluachra」がドロップすることがある。
    right_ear="ディグニタリピアス",
    left_ring="キシャールリング",  --没有 オーメンに出現するゴージャー族NM「Glassy Gorger」がドロップする。
    right_ring="アルビナリング+1",
    back={ name="カムラスマント", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
    }

    sets.midcast.CorsairShot['Light Shot'] = {
	ammo="ライヴブレット",
	head="ムンムボンネット+1",
    body="オショシベスト+1",
    hands="ムンムリスト+1",
    legs="ムンムケックス+2",
    feet="ムンムゲマッシュ+2",
    neck="コモドアチャーム+2",
    waist="エスカンストーン",
    left_ear="ハメティックピアス",
    right_ear="ディグニタリピアス",
    left_ring="キシャールリング",  --オーメンに出現するゴージャー族NM「Glassy Gorger」がドロップする
    right_ring="ムンムリング",  --没有
	--    right_ring="スティキニリング+1",  --没有
    back={ name="カムラスマント", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
	}

    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']
	
	sets.TripleShot = {
	ammo=gear.RAbullet,
	head="オショシマスク+1",
    body="オショシベスト+1",
    hands={ name="ＬＡガントリー+3", augments={'Enhances "Fold" effect',}},
    legs="オショシトラウザ+1",
    feet="オショシレギンス+1",
    neck="コモドアチャーム+2",
 --没有   neck="イスクルゴルゲット",
    waist="イェマヤベルト",
    left_ear="テロスピアス",
    right_ear="エナベートピアス",
    left_ring="イラブラットリング",
    right_ring="ムンムリング",
--    left_ring="スティキニリング+1",  --没有
  --没有    right_ring="Hajduk Ring",
    back={ name="カムラスマント", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
	}
	


    -- Ranged gear
    sets.midcast.RA = {
	ammo=gear.RAbullet,
    head="メガナダバイザー+2",
    body="オショシベスト+1",
    hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="アデマケックス+1",
    feet="メガナダショウス+2",
--没有    neck="イスクルゴルゲット",
    neck="コモドアチャーム+2",
    waist="イェマヤベルト",
    left_ear="テロスピアス",
    right_ear="エナベートピアス",
    left_ring="イラブラットリング",
    right_ring="ラジャスリング",
     back={ name="カムラスマント", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
	}

    sets.midcast.RA.Acc = {
	ammo=gear.RAbullet,
    head="メガナダバイザー+2",
    body="ＬＫトルーズ+3",
    hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="アデマケックス+1",
    feet="メガナダショウス+2",
--没有    neck="イスクルゴルゲット",
    neck="コモドアチャーム+2",
    waist="イェマヤベルト",
    left_ear="エナベートピアス",
    right_ear="ディグニタリピアス",
--    left_ring="スティキニリング+1",  --没有	
    right_ring="ムンムリング",

  --没有    right_ring="Hajduk Ring",
--没有    right_ring="王将の指輪",
    back={ name="カムラスマント", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
	}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    sets.idle = {
	ammo=gear.RAbullet,
	head="メガナダバイザー+2",
    body={ name="ＬＡフラック+3", augments={'Enhances "Loaded Deck" effect',}},
    hands="メガナダグローブ+2",
    legs="ムンムケックス+2",
    feet={ name="ＬＡブーツ+3", augments={'Enhances "Wild Card" effect',}},
    neck="黄昏の光輪",
	waist="霊亀腰帯",
--没有   waist="Flume Belt",
    left_ear="テロスピアス",
    right_ear="エテオレートピアス",
--没有   right_ear="Odnowa Earring +1",	
    left_ring="ヴォーケインリング",
    right_ring="守りの指輪",
    back={ name="カムラスマント", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}
--没有    back="Moonlight Cape",}
    sets.idle.Town = {
	ammo=gear.RAbullet,
	head={ name="ＬＡトリコルヌ+3", augments={'Enhances "Winning Streak" effect',}},
    body={ name="ＬＡフラック+3", augments={'Enhances "Loaded Deck" effect',}},
    hands={ name="ＬＡガントリー+3", augments={'Enhances "Fold" effect',}},
    legs="ムンムケックス+2",
    feet={ name="ＬＡブーツ+3", augments={'Enhances "Wild Card" effect',}},
    neck="コモドアチャーム+2",
    waist="霊亀腰帯",
    left_ear="テロスピアス",
    right_ear="エテオレートピアス",
--没有   right_ear="Odnowa Earring +1",
    left_ring="ヴォーケインリング",
--没有    left_ring="Stikini Ring +1",
    right_ring="守りの指輪",
    back={ name="カムラスマント", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}
--没有    back="Moonlight Cape",}
    
    -- Defense sets
    
    

    sets.Kiting = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged.Melee = {
	ammo=gear.RAbullet,
    head={ name="アデマボンネット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="アデマジャケット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="メガナダショウス+2",
    feet={ name="ヘルクリアブーツ", augments={'Accuracy+29','"Triple Atk."+4','Attack+3',}},
    neck="イスクルゴルゲット",
    waist="霊亀腰帯",
    left_ear="テロスピアス",
    right_ear="セサンスピアス",
    left_ring="イラブラットリング",
    right_ring="エポナリング",
    back={ name="カムラスマント", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}
	
	--28pdt 14mdt base. 40pdt 26mdt with Rostam
	sets.engaged.HybridDT = {
	ammo=gear.RAbullet,
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
    
    sets.engaged.Acc = {
	ammo=gear.RAbullet,
	head="メガナダバイザー+2",
    body={ name="アデマジャケット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="カマインクウィス+1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="ヘルクリアブーツ", augments={'Accuracy+29','"Triple Atk."+4','Attack+3',}},
    neck="リソムネックレス",
    waist="霊亀腰帯",
    left_ear="テロスピアス",
    right_ear="セサンスピアス",
    left_ring="イラブラットリング",
    right_ring="エポナリング",
    back={ name="カムラスマント", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}	

    sets.engaged.TH = { 
--	body={ name="Herculean Vest", augments={'VIT+1','Pet: AGI+9','"Treasure Hunter"+2','Accuracy+12 Attack+12','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
--	hands={ name="Herculean Gloves", augments={'DEX+5','"Fast Cast"+3','"Treasure Hunter"+2',}}, waist="Chaac Belt",
	}
    
    sets.engaged.Acc.DW = {}

    --50 pdt 28mdt
    sets.engaged.Ranged = {
	ammo=gear.RAbullet,
	head="メガナダバイザー+2",  --5 pdt  53 mageva
    body="メガナダクウィリ+2",  --8 pdt 64 mageva
    hands="メガナダグローブ+2",  --4 pdt 37 mageva
    legs="ムンムケックス+2",  --5 dt 107 mageva
    feet="メガナダショウス+2",  --3 pdt 69 mageva
    neck="黄昏の光輪",  --6 dt
    waist="霊亀腰帯",
--没有    waist="Flume Belt",  --4 pdt
    left_ear="テロスピアス",
    right_ear="セサンスピアス",
--没有    right_ear="Odnowa Earring +1",  --2 mdt
    left_ring="ヴォーケインリング",
    right_ring="守りの指輪",  --10 dt
    back={ name="カムラスマント", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},}  -- 5 dt
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
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
    end
 
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
function job_post_midcast(spell, action, spellMap, eventArgs)
     if spell.action_type == 'Ranged Attack' then
        if buffactive['トリプルショット'] then
             equip(sets.TripleShot)
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


	



-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
    if buffactive['Transcendancy'] then
        return 'Brew'
    end
end


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    if newStatus == 'Engaged' and player.equipment.main == 'Chatoyant Staff' then
        state.OffenseMode:set('Ranged')
    end
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    
    msg = msg .. 'Off.: '..state.OffenseMode.current
    msg = msg .. ', Rng.: '..state.RangedMode.current
    msg = msg .. ', WS.: '..state.WeaponskillMode.current
    msg = msg .. ', QD.: '..state.CastingMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
    
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    msg = msg .. ', Roll Size: ' .. ((state.LuzafRing.value and 'Large') or 'Small')
    
    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies' Roll"]     = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.japanese]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(104, spell.japanese..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1
    
    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.element == 'None' then
                -- physical weaponskills
                bullet_name = gear.WSbullet
            else
                -- magical weaponskills
                bullet_name = gear.MAbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['トリプルショット'] then
            bullet_min_count = 3
        end
    end
    
    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
    
    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end
    
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end
    
    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end
        
        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(3, 04)
end