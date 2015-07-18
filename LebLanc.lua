Hax2God's LeBlanc

-- CONSTANTS
local RANGE_Q = 700
local RANGE_W = 600
local RANGE_E = 800
local RANGE_R = 600

local myHero = nil
local myHeroPos = nil

function AfterObjectLoopEvent(myHer0)
    myHero = myHer0
	myHeroPos = GetOrigin(myHero)
    local target = GetCurrentTarget()
		
 if KeyIsDown(0x20) then 
	
	if CanUseSpell(localHero, _Q) == READY then
      target = GetTarget(localHero, RANGE_Q)

      if target then
        local pI = GetPredictionForPlayer(p1, target, GetMoveSpeed(target), 1700, 250, RANGE_W, 50, true, true)

        if pI and pI.HitChance == 1 then
          CastSkillShot(_Q, pI.PredPos.x, pI.PredPos.y, pI.PredPos.z)
        end
      end
    end
  
    if CanUseSpell(myHero, _R) == READY then
	  CastTargetSpell(target, _R)
    end
			
    if CanUseSpell(myHero, _W) == READY then
      CastTargetSpell(target, _W)
    end
		
	if CanUseSpell(myHero, _E) == READY then
      CastTargetSpell(target, _E)
    end
 end

function GetTarget(unit, range)
  local threshold, range_sqr, target = math.huge, range * range
  local p1, p2 = GetOrigin(unit)

  for baseName, enemy in pairs(enemyHeroes) do
    if IsVisible(enemy) and IsObjectAlive(enemy) and not IsImmune(enemy) then
      p2 = GetOrigin(enemy)

      if (p2.x - p1.x) ^ 2 + (p2.z - p1.z) ^ 2 < range_sqr then
        local result = (GetCurrentHP(enemy) + GetMagicShield(enemy) + GetDmgShield(enemy)) / (GetBonusAP(enemy) + (GetBaseDamage(enemy) + GetBonusDmg(enemy)) * GetAttackSpeed(enemy))

        if result < threshold then
          target = enemy; threshold = result
        end
      end
    end
  end

  return target
end
end
