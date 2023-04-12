create or replace NONEDITIONABLE PROCEDURE DOCGEN_XML(
    output       OUT TYPES.cursor_type,
    in_application_id IN NUMBER
) AS 
BEGIN
    OPEN output FOR
    SELECT
        XMLELEMENT(
            "document",
            (
                SELECT
                    XMLELEMENT(
                        "application",
                        (
                            SELECT
                                XMLELEMENT(
                                    "customer",
                                    XMLELEMENT("thaisalutationcodedesc", (SELECT entry_name FROM common_code_category_entry where entry_code = indv.th_salu_code and category_code = 'SALUTATION')),
                                    XMLELEMENT("thainame", indv.th_name_line_2),
                                    XMLELEMENT("thaisurname", indv.th_name_line_1)
                                )
                            from los_cif_indv indv where indv.ca_id = ca.id and indv.cif_rel_code = 'M' and ROWNUM = 1
                        ),
                        XMLELEMENT("application", 
                         (
                            SELECT
                                XMLELEMENT(
                                    "applicationtype",
                                    (SELECT entry_name FROM common_code_category_entry where entry_code = indv.th_salu_code and category_code = 'SALUTATION')),
                    )
                from los_ca ca where ca.id = in_application_id
            )
        ).getClobVal() as xml_str
    from dual;
END DOCGEN_XML;