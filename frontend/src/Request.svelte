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
</script>

{@debug selectOption}
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
    {#if selectOption == "Body"}<Body />{/if}
</div>

<style>
    .request {
        border: 1px solid silver;
        margin-top: 5px;
        width: auto;
        height: 408px;
        text-align: left;
        padding: 8px;
    }
</style>
