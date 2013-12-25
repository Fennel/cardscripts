--Bunni, Eleanor's Servant
function c62077657.initial_effect(c)
	--battle destroyed
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(62077657,0))
	e1:SetCategory(CATEGORY_RECOVER+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c62077657.condition)
	e1:SetTarget(c62077657.target)
	e1:SetOperation(c62077657.operation)
	c:RegisterEffect(e1)
	--lp
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_RECOVER)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c62077657.effcon)
	e4:SetTarget(c62077657.lptg)
	e4:SetOperation(c62077657.lpop)
	c:RegisterEffect(e4)
end
function c62077657.filter2(c)
	return c:IsCode(77366257) and c:IsFaceup()
end
function c62077657.effcon(e)
	return Duel.IsExistingMatchingCard(c62077657.filter2,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil)
end
function c62077657.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE)
		and bit.band(e:GetHandler():GetReason(),REASON_BATTLE)~=0
end
function c62077657.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c62077657.filter(c,e,tp)
	return c:IsCode(62077657) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN)
end
function c62077657.operation(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	local g=Duel.GetMatchingGroup(c62077657.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,nil,e,tp)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(62077657,0)) then
		Duel.BreakEffect()
		Duel.SpecialSummonStep(g:GetFirst(),0,tp,tp,false,false,POS_FACEUP)
		if ft>1 and g:GetCount()>1 and Duel.SelectYesNo(tp,aux.Stringid(62077657,0)) then
			Duel.SpecialSummonStep(g:GetNext(),0,tp,tp,false,false,POS_FACEUP)
		end
		Duel.SpecialSummonComplete()
	end
end
function c62077657.lptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,500)
end
function c62077657.lpop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end