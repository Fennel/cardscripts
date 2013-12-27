--Whyt, Eleanor's Servant
function c56160378.initial_effect(c)
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--cannot be target
	--[[
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c56160378.effcon)
	e2:SetTarget(c56160378.target)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	]]
	--cannot be battle target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c56160378.effcon)
	e2:SetTarget(c56160378.target)
	c:RegisterEffect(e2)
end
function c56160378.filter(c)
	return c:IsCode(77366257) and c:IsFaceup()
end
function c56160378.effcon(e)
	--AI.Chat("condition check")
	--if Duel.IsExistingMatchingCard(c56160378.filter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil) then AI.Chat("Eleanor is faceup!") end
	return Duel.IsExistingMatchingCard(c56160378.filter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil)
end
function c56160378.target(e,c)
	--AI.Chat(c:GetCode())
	--if not c:IsCode(56160378) and c:IsType(TYPE_MONSTER) then
		--AI.Chat("applicable")
	--else AI.Chat("mot applicable") end
	return not c:IsCode(56160378)
end
