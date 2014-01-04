--"C", Eleanor's Servant
function c99215803.initial_effect(c)
	--special summon from hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(99215803,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCost(c99215803.cost)
	e1:SetCondition(c99215803.scon)
	e1:SetTarget(c99215803.stg)
	e1:SetOperation(c99215803.sop)
	c:RegisterEffect(e1)
	--special summon from grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(99215803,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(c99215803.scost)
	e2:SetCondition(c99215803.scon2)
	e2:SetTarget(c99215803.stg)
	e2:SetOperation(c99215803.sop2)
	c:RegisterEffect(e2)
end
function c99215803.sop2(e,tp,eg,ep,ev,re,r,rp,c)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c99215803.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,99215803)==0 end
end
function c99215803.sfilter2(c)
	return c:IsCode(77366257) and c:IsFaceup()
end
function c99215803.scost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,99215803)==0
		and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_GRAVE,0,1,e:GetHandler(),0x3fe) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_GRAVE,0,1,1,e:GetHandler(),0x3fe)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	Duel.RegisterFlagEffect(tp,99215803,RESET_PHASE+PHASE_END,0,1)
end
function c99215803.sfilter(c,tp)
	return c:IsPreviousPosition(POS_FACEUP) and c:IsSetCard(0x3fe) and c:IsType(TYPE_MONSTER) and c:GetPreviousControler()==tp and c:IsReason(REASON_DESTROY) and c:GetReasonPlayer()~=tp
end
function c99215803.scon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c99215803.sfilter,1,nil,tp) and Duel.IsExistingMatchingCard(c99215803.sfilter2,tp,LOCATION_MZONE,0,1,nil) and Duel.GetFlagEffect(tp,99215803)==0
end
function c99215803.stg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	Duel.RegisterFlagEffect(tp,99215803,RESET_PHASE+PHASE_END,0,1)
end
function c99215803.sop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c99215803.scon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_GRAVE,0,1,c,0x3fe) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCount(tp,LOCATION_MZONE) > 0
end
