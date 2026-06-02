<script>
    import "carbon-components-svelte/css/white.css";
    import { TextInput, Button } from "carbon-components-svelte";
    import RowInsert from "carbon-icons-svelte/lib/Add.svelte";
    import RowDelete from "carbon-icons-svelte/lib/TrashCan.svelte";

    let headers = [{ id: Math.random(), key: "", value: "" }];
    export let urlencodedBody = "";

    $: {
        let arr = [];
        for (const h of headers) {
            if (h.key != "") {
                arr.push(encodeURIComponent(h.key) + '=' + encodeURIComponent(h.value));
            }
        }
        urlencodedBody = arr.join("&");
    }

    function addItem() {
        headers = [...headers, { id: Math.random(), key: "", value: "" }];
    }

    function deleteItem(id) {
        if (headers.length > 1) {
            headers = headers.filter(h => h.id !== id);
        } else {
            headers = [{ id: Math.random(), key: "", value: "" }];
        }
    }
</script>

<div class="hm-table-container">
    <div class="hm-table-header">
        <div class="col">Key</div>
        <div class="col">Value</div>
        <div class="col-action"></div>
    </div>
    <div class="hm-table-body">
        {#each headers as item (item.id)}
            <div class="hm-table-row">
                <div class="col">
                    <TextInput
                        placeholder="Key"
                        bind:value={item.key}
                        size="sm"
                    />
                </div>
                <div class="col">
                    <TextInput
                        placeholder="Value"
                        bind:value={item.value}
                        size="sm"
                    />
                </div>
                <div class="col-action">
                    <Button
                        kind="ghost"
                        size="small"
                        icon={RowDelete}
                        on:click={() => deleteItem(item.id)}
                        style="color: var(--hm-text-tertiary)"
                    />
                </div>
            </div>
        {/each}
    </div>
    <div class="hm-table-footer">
        <Button
            kind="tertiary"
            size="small"
            icon={RowInsert}
            on:click={addItem}
            style="border-radius: 10px; font-weight: 500;"
        >Add Row</Button>
    </div>
</div>

<style>
    .hm-table-container {
        display: flex;
        flex-direction: column;
        flex: 1;
        overflow: hidden;
        border: 1px solid var(--ui-text-mute);
        border-radius: var(--ui-radius-md);
        background-color: var(--ui-bg-card);
        opacity: 0.9;
    }
    .hm-table-header {
        display: flex;
        padding: 10px 16px;
        background-color: var(--ui-bg-sub);
        border-bottom: 1px solid rgba(0,0,0,0.06);
    }
    .hm-table-header .col {
        flex: 1;
        font-size: 12px;
        font-weight: 700;
        color: var(--ui-text-desc);
        padding: 0 8px;
    }
    .hm-table-body {
        flex: 1;
        overflow-y: auto;
    }
    .hm-table-row {
        display: flex;
        align-items: center;
        padding: 0;
        border-bottom: 1px solid rgba(0,0,0,0.04);
        background-color: transparent;
        transition: background-color 0.2s ease;
    }
    .hm-table-row:nth-child(even) {
        background-color: rgba(248, 250, 252, 0.5);
    }
    .hm-table-row:hover {
        background-color: rgba(241, 245, 249, 0.8);
    }
    .col {
        flex: 1;
        padding: 0;
        border-right: 1px solid rgba(0,0,0,0.04);
    }
    .col:last-child {
        border-right: none;
    }
    .col-action {
        width: 44px;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 4px 0;
    }
    .hm-table-footer {
        padding: 12px 16px;
        background-color: var(--ui-bg-sub);
        border-top: 1px solid rgba(0,0,0,0.06);
        display: flex;
        justify-content: flex-start;
    }
    
    :global(.hm-table-row .bx--text-input) {
        background-color: transparent !important;
        border: none !important;
        border-radius: 0 !important;
        height: 40px !important;
        padding: 0 12px !important;
        font-family: 'JetBrains Mono', 'Monaco', monospace;
        font-size: 13px !important;
    }
    
    :global(.hm-table-row .bx--text-input:focus) {
        background-color: #fff !important;
        box-shadow: inset 0 0 0 2px var(--brand-primary) !important;
        outline: none !important;
        position: relative;
        z-index: 1;
    }

    :global(.hm-table-footer .bx--btn--tertiary) {
        border-radius: var(--ui-radius-sm) !important;
        padding-left: 12px !important;
        padding-right: 16px !important;
        font-weight: 600 !important;
        border: 1px solid rgba(0,0,0,0.1) !important;
        background-color: var(--ui-bg-card) !important;
        color: var(--ui-text-desc) !important;
        transition: all 0.2s ease !important;
        display: flex !important;
        align-items: center !important;
        gap: 6px !important;
        height: 32px !important;
    }

    :global(.hm-table-footer .bx--btn--tertiary .bx--btn__icon) {
        margin-left: 0 !important;
        margin-right: 0 !important;
        position: static !important;
    }

    :global(.hm-table-footer .bx--btn--tertiary:hover) {
        background-color: var(--brand-primary) !important;
        color: white !important;
        border-color: var(--brand-primary) !important;
        box-shadow: var(--ui-shadow-sm) !important;
    }
</style>
