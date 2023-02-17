<script>
    import "carbon-components-svelte/css/white.css";
    import {
        TextInput,
        Button,
        ContentSwitcher,
        Switch,
    } from "carbon-components-svelte";

    import Body from "./requests/Body.svelte";

    let options = ["Params", "Headers", "Body"];
    let selectIndex = 0;
    $: selectOption = options[selectIndex];
    export let bodyContent;
    export let contentType;
</script>

<ContentSwitcher
    style="min-width:300px; max-width:600px; "
    size="sm"
    bind:selectedIndex={selectIndex}
>
    {#each options as op}
        <Switch text={op} />
    {/each}
</ContentSwitcher>
<div class="request">
    {#if selectOption == "Body"}<Body
            bind:value={bodyContent}
            bind:contentType
        />{/if}
</div>

<style>
    .request {
        border: 1px solid silver;
        margin-top: 5px;
        width: auto;
        min-width: 200px;
        min-height: 280px;
        text-align: left;
        padding: 8px;
    }
</style>
