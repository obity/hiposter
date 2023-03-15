<script>
    import "carbon-components-svelte/css/white.css";
    import { RadioButtonGroup, RadioButton } from "carbon-components-svelte";
    import OtherInput from "./otherInput.svelte";
    import BinaryInput from "./binaryInput.svelte";
    import UrlencodedInput from "./urlencodedInput.svelte";
    import JsonEditor from "../components/JsonEditor.svelte";
    import XmlEditor from "../components/XmlEditor.svelte";
    import HtmlEditor from "../components/HtmlEditor.svelte";
    import JavaScriptEditor from "../components/JavaScriptEditor.svelte";
    let contentTypes = [
        { k: "none", v: "application/none" },
        // { k: "form-data", v: "application/form-data" },
        { k: "x-www-from-urlencoded", v: "application/x-www-from-urlencoded" },
        { k: "JSON", v: "application/json" },
        { k: "Text", v: "application/text" },
        { k: "XML", v: "application/xml" },
        { k: "HTML", v: "application/html" },
        { k: "JavaScript", v: "application/javascript" },
        // { k: "binary", v: "application/binary" },
    ];
    export let contentType = "application/none";
    export let value;
</script>

<RadioButtonGroup
    on:change={() => (value = "")}
    bind:selected={contentType}
    style="position:absolute;height:30px;"
>
    {#each contentTypes as { k, v }}
        <RadioButton labelText={k} value={v} />
    {/each}
</RadioButtonGroup>
<div class="input">
    {#if contentType == "application/json"}
        <JsonEditor bind:value />
    {:else if contentType == "application/xml"}
        <XmlEditor bind:value />
    {:else if contentType == "application/html"}
        <HtmlEditor bind:value />
    {:else if contentType == "application/javascript"}
        <JavaScriptEditor bind:value />
    {:else if contentType == "application/binary"}
        <BinaryInput bind:value />
    {:else if contentType == "application/none"}
        <div />{:else if contentType == "application/x-www-from-urlencoded"}
        <UrlencodedInput bind:urlencodedBody={value} />
    {:else}
        <OtherInput bind:value />
    {/if}
</div>

<style>
    .input {
        margin-top: 25px;
        position: absolute;
        height: 85%;
        width: 99.5%;
    }
</style>
