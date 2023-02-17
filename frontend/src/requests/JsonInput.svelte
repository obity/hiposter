<script>
    import "carbon-components-svelte/css/white.css";
    import { TextArea } from "carbon-components-svelte";
    export let value = "{}";
</script>

<textarea bind:value placeholder="请输入JSON数据" rows={20} />

<style>
    textarea {
        font-size: 15px;
        width: 100%;
    }
</style>
