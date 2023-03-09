<script lang="ts">
    import "carbon-components-svelte/css/white.css";
    import { FileUploader, Button } from "carbon-components-svelte";
    import TrashCan from "carbon-icons-svelte/lib/TrashCan.svelte";

    let fileUploader;
    let files = [];

    $: {
        if (files.length) {
            console.log(files[0].name);
        }
    }
</script>

<div style="overflow: auto;height:280px">
    <FileUploader
        kind="tertiary"
        bind:this={fileUploader}
        multiple
        labelTitle="Upload File"
        buttonLabel="add file "
        status="complete"
        bind:files
    />

    <Button
        disabled={!files.length}
        kind="danger-tertiary"
        size="small"
        iconDescription="Clear file"
        on:click={fileUploader.clearFiles}
        on:click={() => (files = [])}
        icon={TrashCan}
    />
</div>

<style>
</style>
