
if EntityStatProvider == nil then
  Debug.EnabledModules['statprovider:entities'] = false
  DebugPrint ( 'Creating new EntityStatProvider object.' )
  EntityStatProvider = class({})
end

function EntityStatProvider:Init()
  CustomGameEventManager:RegisterListener("statprovider_entities_request", Dynamic_Wrap(self, "EventHandler"))
end

function EntityStatProvider:EventHandler(keys)
  local entity = keys.entity
  local handle = EntIndexToHScript(entity)

  CustomNetTables:SetTableValue("entity_stats", tostring(entity), {
    HealthRegen = handle:GetHealthRegen(),
    ManaRegen = (handle:GetManaRegen() + handle:GetStatsBasedManaRegen()) * handle:GetPercentageBasedManaRegen() + handle:GetConstantBasedManaRegen()
  })
end
