<script>
    import "carbon-components-svelte/css/white.css";
    import { RadioButtonGroup, RadioButton } from "carbon-components-svelte";
    import JsonInput from "./JsonInput.svelte";
    let bodyTypes = [
        "none",
        "form-data",
        "x-www-from-urlencoded",
        "JSON",
        "Text",
        "XML",
        "HTML",
        "JavaScript",
        "binary",
    ];
    let selectdType = "JSON";
</script>

<RadioButtonGroup bind:selected={selectdType}>
    {#each bodyTypes as t}
        <RadioButton labelText={t} value={t} />
    {/each}
</RadioButtonGroup>
{#if selectdType == "JSON"}
    <JsonInput />
{/if}
