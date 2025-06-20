select 
    '' comment_modifiers, 

    'u-color-' || ora_hash(C.created_by, 29) || ' u-color-' || ora_hash(C.created_by, 29) || '-bd' icon_modifier,
    replace(apex_escape.html(dbms_lob.substr(note,2000,1)), chr(10), '<br />') comment_text,

    CASE 
        WHEN VW_EBA_SALES_LEADS.ID IS NOT NULL     AND :APP_PAGE_ID = '94' 
            THEN '<br> <br> <i> Origin: <a href="' ||  apex_page.get_url(p_page => 133, p_items => 'P133_ID', p_values => C.LEAD_ID) || 
                    '" <span style="text-decoration: underline; color: blue;"">Lead</span></i></a> 💼'
        WHEN VW_EBA_SALES_CUSTOMERS.ID IS NOT NULL AND :APP_PAGE_ID = '94' 
            THEN '<br> <br> <i> Origin: <a href="' ||  apex_page.get_url(p_page => 94, p_items => 'P94_ID', p_values => C.ACCOUNT_ID) || 
                    '" <span style="text-decoration: underline; color: blue;"">Account</span></i></a> 🙋‍♂️'
        WHEN VW_EBA_SALES_DEALS.ID IS NOT NULL     AND :APP_PAGE_ID = '94' 
            THEN '<br> <br> <i> Origin: <a href="' ||  apex_page.get_url(p_page => 80, p_items => 'P80_ID', p_values => C.DEAL_ID) || 
                    '" <span style="text-decoration: underline; color: blue;"">Opportunity</span></i></a> 💰'
        ELSE NULL
    END AS attribute_1,

    '' attribute_2,
    '' attribute_3,
    '' attribute_4,

    lower(C.created_by) user_name,

    upper(
      case
        when instr(replace(C.created_by,'.',' '),' ') = 0
        then substr(C.created_by,1,2)
        else substr(C.created_by,1,1)||substr(C.created_by,instr(replace(C.created_by,'.',' '),' ')+1,1)
      end
    ) user_icon,

    case
      when eba_sales_acl_api.get_authorization_level(:APP_USER) = 3
      then '<a href="' || apex_page.get_url(p_page => 22, p_items => 'P22_ID', p_values => C.id) || 
        '" class="t-Button t-Button--small t-Button--simple">Edit</a>'
    end actions,

    C.id update_id,

    case
      when to_char(C.created, 'YYYMMDDHH24MISS') = to_char(C.updated, 'YYYMMDDHH24MISS')
      then apex_util.get_since(C.created) 
      else apex_util.get_since(C.created) || ' (Updated ' || apex_util.get_since(C.updated) || ')' 
    end comment_date
  
from VW_EBA_SALES_COMMENTS C
LEFT JOIN VW_EBA_SALES_LEADS     ON C.LEAD_ID    = VW_EBA_SALES_LEADS.ID
LEFT JOIN VW_EBA_SALES_CUSTOMERS ON C.ACCOUNT_ID = VW_EBA_SALES_CUSTOMERS.ID
LEFT JOIN VW_EBA_SALES_DEALS     ON C.DEAL_ID    = VW_EBA_SALES_DEALS.ID
where (
       
       (:APP_PAGE_ID = '80'  and VW_EBA_SALES_DEALS.ID     = :P80_ID)

    or (:APP_PAGE_ID = '93'  and C.territory_id            = :P93_ID)

    or (:APP_PAGE_ID = '133' and VW_EBA_SALES_LEADS.ID     = :P133_ID)

    or (:APP_PAGE_ID = '94'  AND 
            (VW_EBA_SALES_CUSTOMERS.ID = :P94_ID OR VW_EBA_SALES_DEALS.CUSTOMER_ID = :P94_ID OR VW_EBA_SALES_LEADS.ACCOUNT_ID = :P94_ID) 
       )         

    or (:APP_PAGE_ID = '24'  and C.contact_id              = :P24_ID)

    or (:APP_PAGE_ID = '61'  and C.product_id              = :P61_ID)
)

order by C.created desc