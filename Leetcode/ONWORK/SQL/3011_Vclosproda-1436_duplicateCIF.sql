Vclosproda-1436

select mp.cms_le_main_profile_id, sp.cms_le_sub_profile_id
from SCI_LE_MAIN_PROFILE mp
left join sci_le_sub_profile sp on sp.cms_le_main_profile_id = mp.cms_le_main_profile_id
where mp.lmp_le_id in (select LMP_LE_ID  
from SCI_LE_MAIN_PROFILE
where LMP_LE_ID not in ('-999996','-999999')
group by LMP_LE_ID
having count (LMP_LE_ID)>1)
and not exists (select * from sci_lsp_lmt_profile where cms_customer_id = sp.cms_le_sub_profile_id);


--2
select mp.lmp_le_id,mp.cms_le_main_profile_id, sp.cms_le_sub_profile_id
from SCI_LE_MAIN_PROFILE mp
left join sci_le_sub_profile sp on sp.cms_le_main_profile_id = mp.cms_le_main_profile_id
where mp.lmp_le_id in (select LMP_LE_ID  
from SCI_LE_MAIN_PROFILE
where LMP_LE_ID not in ('-999996','-999999')
group by LMP_LE_ID
having count (LMP_LE_ID)>1)
and not exists (select * from sci_lsp_lmt_profile where cms_customer_id = sp.cms_le_sub_profile_id);


