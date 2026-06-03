<script>
    import "carbon-components-svelte/css/white.css";
    import {
        Select,
        SelectItem,
        TextInput,
        Button,
    } from "carbon-components-svelte";

    let methods = ["GET", "POST", "PUT", "PATCH", "DELETE", "HEAD", "OPTIONS", "TRACE", "CONNECT"];
    export let theMethod;
    export let url = "";
    export let btnValue = "Send";
</script>

<div class="myhead">
    <div class="method-select">
        <Select
            noLabel
            size="sm"
            bind:selected={theMethod}
        >
            {#each methods as m}
                <SelectItem value={m} text={m} />
            {/each}
        </Select>
    </div>
    <div id="url">
        <TextInput
            hideLabel
            labelText="url"
            size="sm"
            bind:value={url}
            placeholder="Enter Request URL..."
        />
    </div>
    <Button on:click type="submit" size="small" style="min-width: 80px;">{btnValue}</Button>
</div>

<style>
    .myhead {
        display: flex;
        align-items: center;
        background-color: var(--ui-bg-sub);
        padding: 8px;
        border-radius: var(--ui-radius-lg);
        transition: all 0.4s cubic-bezier(0.23, 1, 0.32, 1);
        border: 1px solid rgba(0, 0, 0, 0.03);
    }

    .myhead:focus-within {
        background-color: var(--ui-bg-card);
        border-color: var(--brand-primary);
        box-shadow: var(--ui-shadow-lg);
        transform: translateY(-1px);
    }

    .method-select {
        width: 130px;
        padding: 0 4px;
        border-right: 1px solid rgba(0, 0, 0, 0.05);
        display: flex;
        align-items: center;
    }

    :global(.method-select .bx--select-input) {
        border: none !important;
        background: transparent !important;
        font-weight: 800 !important;
        color: var(--brand-primary) !important;
        font-size: 15px !important;
        letter-spacing: 0.02em !important;
        height: 38px !important;
        padding-top: 0 !important;
        padding-bottom: 0 !important;
    }

    #url {
        flex: 1;
        margin: 0 16px;
        display: flex;
        align-items: center;
    }

    :global(#url .bx--text-input) {
        border: none !important;
        background-color: transparent !important;
        font-family: 'JetBrains Mono', 'Monaco', monospace;
        font-size: 14px !important;
        color: var(--ui-text-main) !important;
        font-weight: 500 !important;
        padding: 0 !important;
        height: 38px !important;
    }

    :global(.myhead .bx--btn--primary) {
        min-width: 110px !important;
        height: 40px !important;
        font-size: 13px !important;
        font-weight: 700 !important;
        letter-spacing: 0.04em !important;
        text-transform: uppercase !important;
        border-radius: 20px !important; /* 强制全圆角药丸形 */
        background: var(--brand-gradient) !important;
        box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3) !important;
        border: none !important;
        transition: all 0.3s cubic-bezier(0.23, 1, 0.32, 1) !important;
    }

    :global(.myhead .bx--btn--primary:hover) {
        transform: translateY(-2px) scale(1.02) !important;
        box-shadow: 0 6px 20px rgba(99, 102, 241, 0.4) !important;
    }

    :global(.myhead .bx--btn--primary:active) {
        transform: translateY(0) scale(0.98) !important;
    }
</style>
