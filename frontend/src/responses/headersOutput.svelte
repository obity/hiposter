<script>
    export let headers = [];
</script>

<div class="hm-table-container">
    <div class="hm-table-header">
        <div class="col col-key">Key</div>
        <div class="col col-value">Value</div>
    </div>
    <div class="hm-table-body">
        {#each headers || [] as { key, value }}
            <div class="hm-table-row">
                <div class="col col-key">
                    <span class="header-key">{key}</span>
                </div>
                <div class="col col-value">
                    <span class="header-value">{value}</span>
                </div>
            </div>
        {:else}
            <div class="empty-state">No headers received</div>
        {/each}
    </div>
</div>

<style>
    .hm-table-container {
        display: flex;
        flex-direction: column;
        height: 100%;
        border: 1px solid var(--ui-text-mute);
        border-radius: var(--ui-radius-md);
        background-color: var(--ui-bg-card);
        opacity: 0.9;
        overflow: hidden;
    }
    .hm-table-header {
        display: flex;
        padding: 10px 16px;
        background-color: var(--ui-bg-sub);
        border-bottom: 1px solid rgba(0,0,0,0.06);
    }
    .hm-table-header .col {
        font-size: 12px;
        font-weight: 700;
        color: var(--ui-text-desc);
        padding: 0 8px;
    }
    .col-key {
        width: 30%;
        min-width: 150px;
        border-right: 1px solid rgba(0,0,0,0.04);
    }
    .col-value {
        flex: 1;
    }
    .hm-table-body {
        flex: 1;
        overflow-y: auto;
    }
    .hm-table-row {
        display: flex;
        align-items: stretch;
        padding: 0;
        border-bottom: 1px solid rgba(0,0,0,0.04);
        background-color: transparent;
        transition: background-color 0.2s ease;
        min-height: 36px;
    }
    .hm-table-row:nth-child(even) {
        background-color: rgba(248, 250, 252, 0.5);
    }
    .hm-table-row:hover {
        background-color: rgba(241, 245, 249, 0.8);
    }
    .hm-table-row .col {
        padding: 8px 12px;
        display: flex;
        align-items: center;
        word-break: break-all;
    }
    .header-key {
        font-family: 'JetBrains Mono', 'Monaco', monospace;
        font-size: 13px;
        color: var(--brand-primary);
        font-weight: 600;
    }
    .header-value {
        font-family: 'JetBrains Mono', 'Monaco', monospace;
        font-size: 13px;
        color: var(--ui-text-main);
    }
    .empty-state {
        padding: 24px;
        text-align: center;
        color: var(--ui-text-mute);
        font-size: 13px;
    }
</style>
