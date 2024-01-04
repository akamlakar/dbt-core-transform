{% macro get_target_relation() %}
    {% set target_relation = adapter.get_relation(
        database=target.database,
        schema=target.schema,
        identifier=model.name
    ) %}
    {{ return(target_relation) }}
{% endmacro %}
