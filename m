Return-Path: <linux-mmc+bounces-2394-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8F490309A
	for <lists+linux-mmc@lfdr.de>; Tue, 11 Jun 2024 07:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002CD28956A
	for <lists+linux-mmc@lfdr.de>; Tue, 11 Jun 2024 05:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CF817BB2D;
	Tue, 11 Jun 2024 05:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t2U7oX6n"
X-Original-To: linux-mmc@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8A517BB01;
	Tue, 11 Jun 2024 05:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718083239; cv=none; b=NXpu+w+YX7N8R3fX1ckRc1JYLkJTHvewPu1o+pnB/mOyOSyN/Pzxfqa0+zHG+XcyCh0sFp3fYD6SIyQqu0FFP8ZZ4W2ogKBYqjIcIjuSN95Bb5GhwY9BTQ/Aoi6Z8+midKzbjqCuaHZ19+oEWJ7mCYqiXIUYqg8yS8meTfSBLfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718083239; c=relaxed/simple;
	bh=h5EbTouNBeWu6ijL6yjIHBGpzMBq4QLVp+0JzjpZ7+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2SXxaNkIKTe6MH56tsCV7fxpSCtFQfXDBS5wLeNzVeMTRjxMzqku80MICnU3ymRrXlWjyQnaPpp5ezHTGN6ro0Zi5LMEK9ZdvEyqR/hou69wlSYlqYRflOyoH3GfuwDMT/UPIMPBcj6omCrQZgoKbLMtytDtb6HAm9ID4q5WtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t2U7oX6n; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pzsnAOfifZqQSLy6CuvG93O9Rr4qQBbiyDOq0rei51I=; b=t2U7oX6n7Tjv8GHV4fu28FZ43h
	WGvHDUGMmFkttnRXe8Tvh6R56aak0mOLWfXLZpLoc4mIZp7uxolTLs81R2XqFYNAAXL/lP0Pmi1Nx
	WTcPMpMUjOPsfCfJZHgNG3vV0vM+YzdP6Q12mq9Gmds8iEpzvN2bZDC4SYTfWafIxg2BYqJ1EudC9
	lxEXx7y7RzHs6B4o1uLQYKzfPvl0ZUyW3abl2fb+ncCp5t//264TIuekCdrjXAiJaFJE7QGY7PbVk
	PFaHFUIXV4yFE0Tai88QVbbl/FR62DIBZ7JudTJzjKOoP3TypM3X6oSx37NH807FmHs/42o4ifma+
	h9jcm7GQ==;
Received: from 2a02-8389-2341-5b80-cdb4-8e7d-405d-6b77.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:cdb4:8e7d:405d:6b77] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGtvi-00000007RLM-3OgN;
	Tue, 11 Jun 2024 05:20:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-m68k@lists.linux-m68k.org,
	linux-um@lists.infradead.org,
	drbd-dev@lists.linbit.com,
	nbd@other.debian.org,
	linuxppc-dev@lists.ozlabs.org,
	ceph-devel@vger.kernel.org,
	virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 17/26]  block: move the stable_write flag to queue_limits
Date: Tue, 11 Jun 2024 07:19:17 +0200
Message-ID: <20240611051929.513387-18-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611051929.513387-1-hch@lst.de>
References: <20240611051929.513387-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Move the io_stat flag into the queue_limits feature field so that it can
be set atomically and all I/O is frozen when changing the flag.

The flag is now inherited by blk_stack_limits, which greatly simplifies
the code in dm, and fixed md which previously did not pass on the flag
set on lower devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-debugfs.c         |  1 -
 block/blk-sysfs.c              | 29 +----------------------------
 drivers/block/drbd/drbd_main.c |  5 ++---
 drivers/block/rbd.c            |  9 +++------
 drivers/block/zram/zram_drv.c  |  2 +-
 drivers/md/dm-table.c          | 19 -------------------
 drivers/md/raid5.c             |  6 ++++--
 drivers/mmc/core/queue.c       |  5 +++--
 drivers/nvme/host/core.c       |  9 +++++----
 drivers/nvme/host/multipath.c  |  4 ----
 drivers/scsi/iscsi_tcp.c       |  8 ++++----
 include/linux/blkdev.h         |  9 ++++++---
 12 files changed, 29 insertions(+), 77 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index cbe99444ed1a54..eb73f1d348e5a9 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -88,7 +88,6 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(SYNCHRONOUS),
 	QUEUE_FLAG_NAME(SAME_FORCE),
 	QUEUE_FLAG_NAME(INIT_DONE),
-	QUEUE_FLAG_NAME(STABLE_WRITES),
 	QUEUE_FLAG_NAME(POLL),
 	QUEUE_FLAG_NAME(DAX),
 	QUEUE_FLAG_NAME(STATS),
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 6f58530fb3c08e..cde525724831ef 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -296,37 +296,10 @@ static ssize_t queue_##_name##_store(struct request_queue *q,		 \
 	return queue_feature_store(q, page, count, _feature);		 \
 }
 
-#define QUEUE_SYSFS_BIT_FNS(name, flag, neg)				\
-static ssize_t								\
-queue_##name##_show(struct request_queue *q, char *page)		\
-{									\
-	int bit;							\
-	bit = test_bit(QUEUE_FLAG_##flag, &q->queue_flags);		\
-	return queue_var_show(neg ? !bit : bit, page);			\
-}									\
-static ssize_t								\
-queue_##name##_store(struct request_queue *q, const char *page, size_t count) \
-{									\
-	unsigned long val;						\
-	ssize_t ret;							\
-	ret = queue_var_store(&val, page, count);			\
-	if (ret < 0)							\
-		 return ret;						\
-	if (neg)							\
-		val = !val;						\
-									\
-	if (val)							\
-		blk_queue_flag_set(QUEUE_FLAG_##flag, q);		\
-	else								\
-		blk_queue_flag_clear(QUEUE_FLAG_##flag, q);		\
-	return ret;							\
-}
-
 QUEUE_SYSFS_FEATURE(rotational, BLK_FEAT_ROTATIONAL)
 QUEUE_SYSFS_FEATURE(add_random, BLK_FEAT_ADD_RANDOM)
 QUEUE_SYSFS_FEATURE(iostats, BLK_FEAT_IO_STAT)
-QUEUE_SYSFS_BIT_FNS(stable_writes, STABLE_WRITES, 0);
-#undef QUEUE_SYSFS_BIT_FNS
+QUEUE_SYSFS_FEATURE(stable_writes, BLK_FEAT_STABLE_WRITES);
 
 static ssize_t queue_zoned_show(struct request_queue *q, char *page)
 {
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 2ef29a47807550..f92673f05c7abc 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2698,7 +2698,8 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 		 */
 		.max_hw_sectors		= DRBD_MAX_BIO_SIZE_SAFE >> 8,
 		.features		= BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA |
-					  BLK_FEAT_ROTATIONAL,
+					  BLK_FEAT_ROTATIONAL |
+					  BLK_FEAT_STABLE_WRITES,
 	};
 
 	device = minor_to_device(minor);
@@ -2737,8 +2738,6 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	sprintf(disk->disk_name, "drbd%d", minor);
 	disk->private_data = device;
 
-	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, disk->queue);
-
 	device->md_io.page = alloc_page(GFP_KERNEL);
 	if (!device->md_io.page)
 		goto out_no_io_page;
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ec1f1c7d4275cd..008e850555f41a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4949,7 +4949,6 @@ static const struct blk_mq_ops rbd_mq_ops = {
 static int rbd_init_disk(struct rbd_device *rbd_dev)
 {
 	struct gendisk *disk;
-	struct request_queue *q;
 	unsigned int objset_bytes =
 	    rbd_dev->layout.object_size * rbd_dev->layout.stripe_count;
 	struct queue_limits lim = {
@@ -4979,12 +4978,14 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 		lim.max_write_zeroes_sectors = objset_bytes >> SECTOR_SHIFT;
 	}
 
+	if (!ceph_test_opt(rbd_dev->rbd_client->client, NOCRC))
+		lim.features |= BLK_FEAT_STABLE_WRITES;
+
 	disk = blk_mq_alloc_disk(&rbd_dev->tag_set, &lim, rbd_dev);
 	if (IS_ERR(disk)) {
 		err = PTR_ERR(disk);
 		goto out_tag_set;
 	}
-	q = disk->queue;
 
 	snprintf(disk->disk_name, sizeof(disk->disk_name), RBD_DRV_NAME "%d",
 		 rbd_dev->dev_id);
@@ -4996,10 +4997,6 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 		disk->minors = RBD_MINORS_PER_MAJOR;
 	disk->fops = &rbd_bd_ops;
 	disk->private_data = rbd_dev;
-
-	if (!ceph_test_opt(rbd_dev->rbd_client->client, NOCRC))
-		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, q);
-
 	rbd_dev->disk = disk;
 
 	return 0;
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aad840fc7e18e3..f8f1b5b54795ac 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2208,6 +2208,7 @@ static int zram_add(void)
 #if ZRAM_LOGICAL_BLOCK_SIZE == PAGE_SIZE
 		.max_write_zeroes_sectors	= UINT_MAX,
 #endif
+		.features			= BLK_FEAT_STABLE_WRITES,
 	};
 	struct zram *zram;
 	int ret, device_id;
@@ -2246,7 +2247,6 @@ static int zram_add(void)
 	/* Actual capacity set using sysfs (/sys/block/zram<id>/disksize */
 	set_capacity(zram->disk, 0);
 	blk_queue_flag_set(QUEUE_FLAG_SYNCHRONOUS, zram->disk->queue);
-	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, zram->disk->queue);
 	ret = device_add_disk(NULL, zram->disk, zram_disk_groups);
 	if (ret)
 		goto out_cleanup_disk;
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 3e3b713502f61e..f4e1b50ffdcda5 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1819,13 +1819,6 @@ static bool dm_table_supports_secure_erase(struct dm_table *t)
 	return true;
 }
 
-static int device_requires_stable_pages(struct dm_target *ti,
-					struct dm_dev *dev, sector_t start,
-					sector_t len, void *data)
-{
-	return bdev_stable_writes(dev->bdev);
-}
-
 int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 			      struct queue_limits *limits)
 {
@@ -1862,18 +1855,6 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	if (dm_table_any_dev_attr(t, device_dax_write_cache_enabled, NULL))
 		dax_write_cache(t->md->dax_dev, true);
 
-	/*
-	 * Some devices don't use blk_integrity but still want stable pages
-	 * because they do their own checksumming.
-	 * If any underlying device requires stable pages, a table must require
-	 * them as well.  Only targets that support iterate_devices are considered:
-	 * don't want error, zero, etc to require stable pages.
-	 */
-	if (dm_table_any_dev_attr(t, device_requires_stable_pages, NULL))
-		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, q);
-	else
-		blk_queue_flag_clear(QUEUE_FLAG_STABLE_WRITES, q);
-
 	/*
 	 * For a zoned target, setup the zones related queue attributes
 	 * and resources necessary for zone append emulation if necessary.
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 675c68fa6c6403..e875763d69917d 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7082,12 +7082,14 @@ raid5_store_skip_copy(struct mddev *mddev, const char *page, size_t len)
 		err = -ENODEV;
 	else if (new != conf->skip_copy) {
 		struct request_queue *q = mddev->gendisk->queue;
+		struct queue_limits lim = queue_limits_start_update(q);
 
 		conf->skip_copy = new;
 		if (new)
-			blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, q);
+			lim.features |= BLK_FEAT_STABLE_WRITES;
 		else
-			blk_queue_flag_clear(QUEUE_FLAG_STABLE_WRITES, q);
+			lim.features &= ~BLK_FEAT_STABLE_WRITES;
+		err = queue_limits_commit_update(q, &lim);
 	}
 	mddev_unlock_and_resume(mddev);
 	return err ?: len;
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index da00904d4a3c7e..d0b3ca8a11f071 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -378,13 +378,14 @@ static struct gendisk *mmc_alloc_disk(struct mmc_queue *mq,
 		lim.max_segments = host->max_segs;
 	}
 
+	if (mmc_host_is_spi(host) && host->use_spi_crc)
+		lim.features |= BLK_FEAT_STABLE_WRITES;
+
 	disk = blk_mq_alloc_disk(&mq->tag_set, &lim, mq);
 	if (IS_ERR(disk))
 		return disk;
 	mq->queue = disk->queue;
 
-	if (mmc_host_is_spi(host) && host->use_spi_crc)
-		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, mq->queue);
 	blk_queue_rq_timeout(mq->queue, 60 * HZ);
 
 	dma_set_max_seg_size(mmc_dev(host), queue_max_segment_size(mq->queue));
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0d753fe71f35b0..5ecf762d7c8837 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3724,6 +3724,7 @@ static void nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)
 
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 {
+	struct queue_limits lim = { };
 	struct nvme_ns *ns;
 	struct gendisk *disk;
 	int node = ctrl->numa_node;
@@ -3732,7 +3733,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (!ns)
 		return;
 
-	disk = blk_mq_alloc_disk(ctrl->tagset, NULL, ns);
+	if (ctrl->opts && ctrl->opts->data_digest)
+		lim.features |= BLK_FEAT_STABLE_WRITES;
+
+	disk = blk_mq_alloc_disk(ctrl->tagset, &lim, ns);
 	if (IS_ERR(disk))
 		goto out_free_ns;
 	disk->fops = &nvme_bdev_ops;
@@ -3741,9 +3745,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	ns->disk = disk;
 	ns->queue = disk->queue;
 
-	if (ctrl->opts && ctrl->opts->data_digest)
-		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
-
 	if (ctrl->ops->supports_pci_p2pdma &&
 	    ctrl->ops->supports_pci_p2pdma(ctrl))
 		blk_queue_flag_set(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index eea727cfa9e67d..173796f2ddea9f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -868,10 +868,6 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 		nvme_mpath_set_live(ns);
 	}
 
-	if (test_bit(QUEUE_FLAG_STABLE_WRITES, &ns->queue->queue_flags) &&
-	    ns->head->disk)
-		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES,
-				   ns->head->disk->queue);
 #ifdef CONFIG_BLK_DEV_ZONED
 	if (blk_queue_is_zoned(ns->queue) && ns->head->disk)
 		ns->head->disk->nr_zones = ns->disk->nr_zones;
diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 60688f18fac6f7..c708e105963833 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -1057,15 +1057,15 @@ static umode_t iscsi_sw_tcp_attr_is_visible(int param_type, int param)
 	return 0;
 }
 
-static int iscsi_sw_tcp_slave_configure(struct scsi_device *sdev)
+static int iscsi_sw_tcp_device_configure(struct scsi_device *sdev,
+		struct queue_limits *lim)
 {
 	struct iscsi_sw_tcp_host *tcp_sw_host = iscsi_host_priv(sdev->host);
 	struct iscsi_session *session = tcp_sw_host->session;
 	struct iscsi_conn *conn = session->leadconn;
 
 	if (conn->datadgst_en)
-		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES,
-				   sdev->request_queue);
+		lim->features |= BLK_FEAT_STABLE_WRITES;
 	return 0;
 }
 
@@ -1083,7 +1083,7 @@ static const struct scsi_host_template iscsi_sw_tcp_sht = {
 	.eh_device_reset_handler= iscsi_eh_device_reset,
 	.eh_target_reset_handler = iscsi_eh_recover_target,
 	.dma_boundary		= PAGE_SIZE - 1,
-	.slave_configure        = iscsi_sw_tcp_slave_configure,
+	.device_configure	= iscsi_sw_tcp_device_configure,
 	.proc_name		= "iscsi_tcp",
 	.this_id		= -1,
 	.track_queue_depth	= 1,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f8e38f94fd8c9a..db14c61791e022 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -298,13 +298,17 @@ enum {
 
 	/* do disk/partitions IO accounting */
 	BLK_FEAT_IO_STAT			= (1u << 4),
+
+	/* don't modify data until writeback is done */
+	BLK_FEAT_STABLE_WRITES			= (1u << 5),
 };
 
 /*
  * Flags automatically inherited when stacking limits.
  */
 #define BLK_FEAT_INHERIT_MASK \
-	(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA | BLK_FEAT_ROTATIONAL)
+	(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA | BLK_FEAT_ROTATIONAL | \
+	 BLK_FEAT_STABLE_WRITES)
 
 /* internal flags in queue_limits.flags */
 enum {
@@ -565,7 +569,6 @@ struct request_queue {
 #define QUEUE_FLAG_SYNCHRONOUS	11	/* always completes in submit context */
 #define QUEUE_FLAG_SAME_FORCE	12	/* force complete on same CPU */
 #define QUEUE_FLAG_INIT_DONE	14	/* queue is initialized */
-#define QUEUE_FLAG_STABLE_WRITES 15	/* don't modify blks until WB is done */
 #define QUEUE_FLAG_POLL		16	/* IO polling enabled if set */
 #define QUEUE_FLAG_DAX		19	/* device supports DAX */
 #define QUEUE_FLAG_STATS	20	/* track IO start and completion times */
@@ -1324,7 +1327,7 @@ static inline bool bdev_stable_writes(struct block_device *bdev)
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
 	    q->limits.integrity.csum_type != 0)
 		return true;
-	return test_bit(QUEUE_FLAG_STABLE_WRITES, &q->queue_flags);
+	return q->limits.features & BLK_FEAT_STABLE_WRITES;
 }
 
 static inline bool blk_queue_write_cache(struct request_queue *q)
-- 
2.43.0


