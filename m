Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188A9227DD0
	for <lists+linux-mmc@lfdr.de>; Tue, 21 Jul 2020 12:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgGUKzG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 21 Jul 2020 06:55:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31687 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728097AbgGUKzG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jul 2020 06:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595328905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xgMI0PUysaqC29ZhpllDxU2MZgp5OTSppOCpTSOb14s=;
        b=IAauyeN8rQXpkKab4sdR+SK5zUNaUvMnFOXCcHQUeh4ddkjACOn3+1g1JWUpItCqxj10m2
        8ASoUDLRO0XUnYqTenagvEz3AmahvcrR/G1IYM3qX8w7A2ytZwTqWIf+7udMumuEadDciS
        3wA1P2I+4a3nOLgIIDNGcyQrhXl+ppM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-aJsSQekbMPSFFHYbUkQrHg-1; Tue, 21 Jul 2020 06:55:03 -0400
X-MC-Unique: aJsSQekbMPSFFHYbUkQrHg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF672107ACCA;
        Tue, 21 Jul 2020 10:54:59 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23A671C4;
        Tue, 21 Jul 2020 10:54:49 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-scsi@vger.kernel.org (open list:SCSI CDROM DRIVER),
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jason Wang <jasowang@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ajay Joshi <ajay.joshi@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        linux-mmc@vger.kernel.org (open list:SONY MEMORYSTICK SUBSYSTEM),
        Christoph Hellwig <hch@lst.de>,
        Satya Tangirala <satyat@google.com>,
        nbd@other.debian.org (open list:NETWORK BLOCK DEVICE (NBD)),
        Hou Tao <houtao1@huawei.com>, Jens Axboe <axboe@fb.com>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO CORE AND
        NET DRIVERS), "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Alex Dubov <oakad@yahoo.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 07/10] block: mspro_blk: use blk_is_valid_logical_block_size
Date:   Tue, 21 Jul 2020 13:52:36 +0300
Message-Id: <20200721105239.8270-8-mlevitsk@redhat.com>
In-Reply-To: <20200721105239.8270-1-mlevitsk@redhat.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/memstick/core/mspro_block.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index cd6b8d4f23350..86c9eb0aef512 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -1199,6 +1199,12 @@ static int mspro_block_init_disk(struct memstick_dev *card)
 
 	msb->page_size = be16_to_cpu(sys_info->unit_size);
 
+	if (!(blk_is_valid_logical_block_size(msb->page_size))) {
+		dev_warn(&card->dev,
+			 "unsupported block size %d", msb->page_size);
+		return -EINVAL;
+	}
+
 	mutex_lock(&mspro_block_disk_lock);
 	disk_id = idr_alloc(&mspro_block_disk_idr, card, 0, 256, GFP_KERNEL);
 	mutex_unlock(&mspro_block_disk_lock);
-- 
2.26.2

