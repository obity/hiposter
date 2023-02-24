<script>
    import "carbon-components-svelte/css/white.css";
    import { RadioButtonGroup, RadioButton } from "carbon-components-svelte";
    import JsonInput from "./JsonInput.svelte";
    import OtherInput from "./otherInput.svelte";
    import BinaryInput from "./binaryInput.svelte";
    import UrlencodedInput from "./urlencodedInput.svelte";
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
<RadioButtonGroup on:change={() => (value = "")} bind:selected={contentType}>
    {#each contentTypes as { k, v }}
        <RadioButton labelText={k} value={v} />
    {/each}
</RadioButtonGroup>
{#if contentType == "application/json"}
    <JsonInput bind:value />
{:else if contentType == "application/binary"}
    <BinaryInput bind:value />
{:else if contentType == "application/none"}
    <div
        style="overflow: auto;height:260px"
    />{:else if contentType == "application/x-www-from-urlencoded"}
    <UrlencodedInput bind:urlencodedBody={value} />
{:else}
    <OtherInput bind:value />
{/if}
