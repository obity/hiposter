<script>
    import "carbon-components-svelte/css/white.css";
    import { RadioButtonGroup, RadioButton } from "carbon-components-svelte";
    import JsonInput from "./JsonInput.svelte";
    import OtherInput from "./otherInput.svelte";
    import BinaryInput from "./binaryInput.svelte";
    let contentTypes = [
        { k: "none", v: "application/none" },
        { k: "form-data", v: "application/form-data" },
        { k: "x-www-from-urlencoded", v: "application/x-www-from-urlencoded" },
        { k: "JSON", v: "application/json" },
        { k: "Text", v: "application/text" },
        { k: "XML", v: "application/xml" },
        { k: "HTML", v: "application/html" },
        { k: "JavaScript", v: "application/javaScript" },
        { k: "binary", v: "application/binary" },
    ];
    export let contentType = "application/none";
    export let value;
</script>

<!-- {@debug contentType} -->
<RadioButtonGroup bind:selected={contentType}>
    {#each contentTypes as { k, v }}
        <RadioButton labelText={k} value={v} />
    {/each}
</RadioButtonGroup>
{#if contentType == "application/json"}
    <JsonInput bind:value />
{:else if contentType == "application/binary"}
    <BinaryInput bind:files={value} />
{:else}
    <OtherInput bind:value placeholder={contentType} />
{/if}
