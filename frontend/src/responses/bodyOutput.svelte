<script>
    export let result = "";

    // 辅助函数：如果是空字符串显示提示
    $: displayResult = result || "Empty response body";
</script>

<div class="raw-container">
    <pre class="raw-content"><code>{displayResult}</code></pre>
</div>

<style>
    .raw-container {
        width: 100%;
        height: 100%;
        background-color: var(--ui-bg-card);
        overflow: auto;
        position: relative;
    }

    .raw-content {
        margin: 0;
        padding: 20px;
        font-family: 'JetBrains Mono', 'Fira Code', 'Monaco', 'Menlo', monospace;
        font-size: 13px;
        line-height: 1.6;
        color: var(--ui-text-desc);
        white-space: pre-wrap;
        word-break: break-all;
    }

    /* 美化滚动条以匹配编辑器风格 */
    .raw-container::-webkit-scrollbar {
        width: 8px;
        height: 8px;
    }
    .raw-container::-webkit-scrollbar-track {
        background: transparent;
    }
    .raw-container::-webkit-scrollbar-thumb {
        background: rgba(0, 0, 0, 0.05);
        border-radius: 10px;
    }
    .raw-container::-webkit-scrollbar-thumb:hover {
        background: rgba(0, 0, 0, 0.1);
    }
</style>
