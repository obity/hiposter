<script>
    import { createEventDispatcher } from "svelte";
    import { Button, ListBox, ListBoxField, ListBoxMenu, ListBoxMenuItem } from "carbon-components-svelte";
    import HistoryIcon from "carbon-icons-svelte/lib/Time.svelte";
    import TrashIcon from "carbon-icons-svelte/lib/TrashCan.svelte";
    import CloseIcon from "carbon-icons-svelte/lib/Close.svelte";

    export let history = [];
    const dispatch = createEventDispatcher();

    function selectHistory(item) {
        dispatch("select", item);
    }

    function clearHistory() {
        dispatch("clear");
    }

    function deleteHistoryItem(index, event) {
        event.stopPropagation(); // 防止触发选中事件
        dispatch("deleteItem", index);
    }

    function getMethodColor(method) {
        const colors = {
            'GET': 'var(--ui-success)',
            'POST': 'var(--ui-warning)',
            'PUT': 'var(--ui-info)',
            'PATCH': 'var(--brand-secondary)',
            'DELETE': 'var(--ui-error)',
            'HEAD': 'var(--ui-text-mute)',
            'OPTIONS': '#0ea5e9',
            'TRACE': '#14b8a6',
            'CONNECT': '#f43f5e'
        };
        return colors[method] || 'var(--ui-text-main)';
    }
</script>

<div class="sidebar anim-fade-in">
    <div class="sidebar-header">
        <div class="brand-box">
            <HistoryIcon size={18} fill="white" />
        </div>
        <span class="title">History</span>
        <Button
            kind="ghost"
            size="small"
            icon={TrashIcon}
            on:click={clearHistory}
            style="color: var(--ui-text-mute)"
        />
    </div>
    <div class="history-list">
        {#each history as item, i}
            <div class="history-item-container" style="animation: slideInRight {0.2 + i * 0.05}s ease forwards;">
                <div class="history-item" on:click={() => selectHistory(item)}>
                    <div class="method-bar" style="background: {getMethodColor(item.method)}"></div>
                    <div class="history-content">
                        <div class="history-meta">
                            <span class="history-method" style="color: {getMethodColor(item.method)}">{item.method}</span>
                        </div>
                        <div class="url">{item.url}</div>
                    </div>
                    <div class="item-delete-btn" on:click={(e) => deleteHistoryItem(i, e)} title="Delete">
                        <CloseIcon size={16} />
                    </div>
                </div>
            </div>
        {:else}
            <div class="empty-state">
                <div class="empty-glass-icon">🧊</div>
                <p>No History Yet</p>
            </div>
        {/each}
    </div>
</div>

<style>
    .sidebar {
        width: 280px;
        height: 100%;
        display: flex;
        flex-direction: column;
        background: rgba(248, 250, 252, 0.8);
        backdrop-filter: blur(12px);
        border-right: 1px solid rgba(0, 0, 0, 0.05);
        z-index: 20;
    }
    .sidebar-header {
        padding: 32px 24px 20px 24px;
        display: flex;
        align-items: center;
        gap: 12px;
    }
    .brand-box {
        background: var(--brand-gradient);
        width: 34px;
        height: 34px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
    }
    .sidebar-header .title {
        flex: 1;
        font-weight: 800;
        font-size: 16px;
        letter-spacing: -0.02em;
        color: var(--ui-text-main);
    }
    .history-list {
        flex: 1;
        overflow-y: auto;
        padding: 8px 16px;
    }
    .history-item-container {
        opacity: 0;
        margin-bottom: 8px;
    }
    .history-item {
        padding: 12px 14px;
        cursor: pointer;
        border-radius: var(--ui-radius-md);
        display: flex;
        align-items: center;
        gap: 12px;
        background: transparent;
        transition: all 0.3s cubic-bezier(0.23, 1, 0.32, 1);
        border: 1px solid transparent;
        position: relative;
        overflow: hidden;
    }
    .history-item:hover {
        background: var(--ui-bg-card);
        border-color: rgba(0, 0, 0, 0.04);
        box-shadow: var(--ui-shadow-md);
        transform: translateX(4px);
    }
    .method-bar {
        width: 3px;
        height: 24px;
        border-radius: 2px;
        flex-shrink: 0;
    }
    .history-content {
        flex: 1;
        min-width: 0;
    }
    .history-meta {
        display: flex;
        align-items: center;
        margin-bottom: 4px;
        line-height: 1;
    }
    .history-method {
        font-size: 11px;
        font-weight: 800;
        letter-spacing: 0.02em;
    }
    .url {
        font-size: 12px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        color: var(--ui-text-desc);
        font-weight: 500;
        line-height: 1.2;
    }
    .empty-state {
        padding: 80px 20px;
        text-align: center;
        color: var(--ui-text-mute);
    }
    .empty-glass-icon {
        font-size: 40px;
        margin-bottom: 16px;
        filter: grayscale(1);
        opacity: 0.3;
    }
    .empty-state p {
        font-size: 14px;
        font-weight: 600;
    }
    .item-delete-btn {
        opacity: 0;
        display: flex;
        align-items: center;
        justify-content: center;
        width: 24px;
        height: 24px;
        border-radius: 6px;
        color: var(--ui-text-mute);
        transition: all 0.2s ease;
        flex-shrink: 0;
    }
    .history-item:hover .item-delete-btn {
        opacity: 1;
    }
    .item-delete-btn:hover {
        background-color: #FF4C5120;
        color: #FF4C51;
    }
</style>
