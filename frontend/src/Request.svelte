<script>
    import "carbon-components-svelte/css/white.css";
    import { ContentSwitcher, Switch } from "carbon-components-svelte";

    import Body from "./requests/Body.svelte";
    import Headers from "./requests/Headers.svelte";
    import Params from "./requests/Params.svelte";

    let options = ["Params", "Headers", "Body"];
    let selectIndex = 0;
    $: selectOption = options[selectIndex];
    export let bodyContent;
    export let contentType;
    export let headers;
    export let params;
</script>

<ContentSwitcher
    style="min-width:300px; max-width:600px; font-size: 15px;"
    size="sm"
    bind:selectedIndex={selectIndex}
>
    {#each options as op}
        <Switch text={op} />
    {/each}
</ContentSwitcher>
<div class="request" >
    {#if selectOption == "Body"}<Body
            bind:value={bodyContent}
            bind:contentType
        />
    {/if}

    {#if selectOption == "Headers"}
        <legend>Headers</legend>
        <Headers bind:headers />
    {/if}
    {#if selectOption == "Params"}
        <legend>Query Params</legend>
        <Params on:click bind:params />
    {/if}
</div>

<style>
    .request {
        border: 1px solid silver;
        margin-top: 5px;
        width: 100%;
        height: 100%;
        text-align: left;
        padding: 8px;
        overflow: hidden;
    }
    legend {
        margin-bottom: 5px;
    }
</style>
