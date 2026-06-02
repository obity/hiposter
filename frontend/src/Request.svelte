<script>
    import "carbon-components-svelte/css/white.css";
    // import { ContentSwitcher, Switch } from "carbon-components-svelte";

    import Body from "./requests/Body.svelte";
    import Headers from "./requests/Headers.svelte";
    import Params from "./requests/Params.svelte";
    import Auth from "./requests/Auth.svelte";

    let options = ["Params", "Headers", "Body", "Auth"];
    export let selectIndex = 0;
    $: selectOption = options[selectIndex];
    export let bodyContent;
    export let contentType;
    export let headers;
    export let params;
    export let authData;
</script>

<div class="request-container">
    {#if selectOption == "Body"}
        <Body bind:value={bodyContent} bind:contentType />
    {/if}

    {#if selectOption == "Headers"}
        <div class="section-label">Headers</div>
        <Headers bind:headers />
    {/if}
    {#if selectOption == "Params"}
        <div class="section-label">Query Params</div>
        <Params on:click bind:params />
    {/if}
    {#if selectOption == "Auth"}
        <div class="section-label">Authentication</div>
        <Auth bind:authData />
    {/if}
</div>

<style>
    .request-container {
        height: 100%;
        width: 100%;
        text-align: left;
        padding: 16px;
        display: flex;
        flex-direction: column;
        overflow-y: auto;
    }
    .section-label {
        font-size: 14px;
        font-weight: 700;
        color: var(--hm-text-primary);
        margin-bottom: 16px;
        padding-left: 4px;
    }
</style>
