Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC11C39DB03
	for <lists+linux-mmc@lfdr.de>; Mon,  7 Jun 2021 13:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhFGLVC (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 7 Jun 2021 07:21:02 -0400
Received: from mail-ua1-f47.google.com ([209.85.222.47]:37835 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhFGLVB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jun 2021 07:21:01 -0400
Received: by mail-ua1-f47.google.com with SMTP id w28so9475857uae.4
        for <linux-mmc@vger.kernel.org>; Mon, 07 Jun 2021 04:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/5i5bpc7ixLhZUjMUOg33ul4jZmR+QFPeRh5P0htgc=;
        b=vVxkYQ9eXiEr9STNA7rUsJImVbLBX20E77jJO5QGvqv017E+1h0omzbsKrjDkO9QzT
         Pj9amLm6hgjrWw2au4zBSYpQW3cbVnf+BQAyoh/yrXbasUw91E3+IFQ6Wg0NORZy/H3O
         WdPO+ox7Umtoxse034Lqhspgp/devs5wudZBFRAq33t8gpC3DdfjqarmJfta8oEPYnxh
         X1CWAKgDD1vWFJhpnsZj8BxKmN5IlmDNz0iul1LapBAIh/lRchK9GhUVzaTRy3rr1rNq
         mC/pVyhT7KWVDjuMAmBYB70FfYGVbcGq7Z+VOLSnpKOvfwVweA07aP2YLXWMEczaQrS+
         cAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/5i5bpc7ixLhZUjMUOg33ul4jZmR+QFPeRh5P0htgc=;
        b=P3cjeatkz7S4fvZfttNJ2fkElkojuoTeg6ycOmL1OP7hscrPYO6NlRVXNIiyN2MLGX
         EG7NBa7LljJ/PaOgZLd0ioFiIpQhZ3e2n8uOOXc3907Mjv05+UEz16Z9v2GFeN4dPyMC
         SO21EQ+EDNV9gfzURS4ZuanDHaPShBY9UiwzGJOu+dzYIB6rcg+RsBmw1QpA4kbxSx0A
         5hhKpTaBA722G63rFGESEnu+FWFd7kvuSf0MuZps3jhFuMwFBvoNSBM65PMmMw97lPAX
         sft5ovi5aPdMtWMCJ73LdcNjmEytgK+pUvHhrySNIvT7F9a1hmb/mtMnAcgwc8QCH4VI
         Qrdw==
X-Gm-Message-State: AOAM533ZZudzDqulM4HpaI75btl/ARERPNawhkLerQaec+w+1YPKHrby
        zBiwB1nY9FUwfAewvRrXlOFw5Z1U3/Y+C/tUuvqVvRI+L5MAsw==
X-Google-Smtp-Source: ABdhPJw+MbXtgyuuQHVZwpp8KLbqarm/BN41ckUSCBV2FZwS231/MD0P5D/z3UtVg+hAVXa2tf0PnRwTLHEtzZieaf4=
X-Received: by 2002:ab0:100f:: with SMTP id f15mr8831881uab.100.1623064680257;
 Mon, 07 Jun 2021 04:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210120121047.2601-1-bbudiredla@marvell.com> <20210120121047.2601-2-bbudiredla@marvell.com>
 <CAPDyKFoF7jz-mbsY8kPUGca5civFKRRyPpHbRkj9P=xevRRfbA@mail.gmail.com> <CY4PR1801MB2070F43EFCB9139D8168164FDE3A9@CY4PR1801MB2070.namprd18.prod.outlook.com>
In-Reply-To: <CY4PR1801MB2070F43EFCB9139D8168164FDE3A9@CY4PR1801MB2070.namprd18.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Jun 2021 13:17:23 +0200
Message-ID: <CAPDyKFrVQbALjSeFBckaZQgkgwcBVuwHy563pdBxHQNA7bxRnQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v5 1/2] mmc: Support kmsg dumper based on pstore/blk
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 5 Jun 2021 at 12:31, Bhaskara Budiredla <bbudiredla@marvell.com> wrote:
>
> Hi Uffe,
>
> With due respect to pstore/blk subsystem changes we have been waiting since long time to see Christoph patches taken.

What patches are you referring to?

> But unfortunately it is still finding at that same stage only. Can you please take up my patch in the current form
> (which is based on current pstore/blk framework) instead of waiting indefinitely. If pstore/blk comes up with the changes
> that has been discussed by you previously, I will further submit the corresponding changes for eMMC devices.

No, I am sorry, but that's not the way it works.

If you really want to move things forward, I would suggest that you
try to implement something along the lines of what I have suggested.
Another option is to post an RFD/RFC so as solution can be discussed
with the relevant people.

Kind regards
Uffe

>
> Thanks,
> Bhaskara
>
> >-----Original Message-----
> >From: Ulf Hansson <ulf.hansson@linaro.org>
> >Sent: Wednesday, January 20, 2021 8:36 PM
> >To: Bhaskara Budiredla <bbudiredla@marvell.com>; Kees Cook
> ><keescook@chromium.org>
> >Cc: Colin Cross <ccross@android.com>; Tony Luck <tony.luck@intel.com>;
> >Sunil Kovvuri Goutham <sgoutham@marvell.com>; linux-
> >mmc@vger.kernel.org; Linux Kernel Mailing List <linux-
> >kernel@vger.kernel.org>; linux-block <linux-block@vger.kernel.org>; Jens
> >Axboe <axboe@kernel.dk>; Christoph Hellwig <hch@lst.de>
> >Subject: [EXT] Re: [PATCH v5 1/2] mmc: Support kmsg dumper based on
> >pstore/blk
> >
> >External Email
> >
> >----------------------------------------------------------------------
> >+ linux-block, Jens, Christoph
> >
> >On Wed, 20 Jan 2021 at 13:11, Bhaskara Budiredla
> ><bbudiredla@marvell.com> wrote:
> >>
> >> This patch introduces to mmcpstore. The functioning of mmcpstore is
> >> similar to mtdpstore. mmcpstore works on FTL based flash devices
> >> whereas mtdpstore works on raw flash devices. When the system crashes,
> >> mmcpstore stores the kmsg panic and oops logs to a user specified MMC
> >> device.
> >>
> >> It collects the details about the host MMC device through pstore/blk
> >> "blkdev" parameter. The user can specify the MMC device in many ways
> >> by checking in Documentation/admin-guide/pstore-blk.rst.
> >>
> >> The individual mmc host drivers have to define suitable polling and
> >> cleanup subroutines to write kmsg panic/oops logs through mmcpstore.
> >> These new host operations are needed as pstore panic write runs with
> >> interrupts disabled.
> >
> >Okay, let me again try to clarify on how I see this to move this forward.
> >
> >1)
> >In my opinion, pstore shouldn't be using callbacks for *regular* I/O
> >read/writes. It's upside-down of how the storage stack is designed to work.
> >
> >Instead, pstore should be implemented as a regular filesystem, that can be
> >mounted on top of a regular block device partition. In this way, the lower
> >layer block device drivers (as mmc), don't need special support for pstore, the
> >regular I/O block read/write path will just work as is.
> >
> >2)
> >When it comes to supporting *panic* writes for pstore, things become a bit
> >more complicated. For sure some adaptations are needed in each block device
> >driver to support this.
> >
> >However, the current method means relying on the lower level block device
> >driver to figure out the pstore partition. Based on that, it should then register
> >itself for pstore support and hook up callbacks for the corresponding block
> >device driver instance, at least that is what it looks like to me. Again, I think
> >this is upside-down from the storage stack perspective. The partition to use
> >for pstore, should be based upon its file system mount point.
> >
> >Furthermore, I think the responsibility for lower layer block device drivers
> >should instead be to just "register/announce" themselves as capable of
> >supporting "panic writes", if they can. Exactly how to best do this, probably
> >needs to be discussed further with the block device people, I think. I have
> >looped in Jens and Christoph, perhaps they can share their opinion in this.
> >
> >That said, it looks to me that pstore needs more work before it's ready to be
> >adopted for generic support in block device drivers.
> >
> >Kind regards
> >Uffe
> >
> >>
> >> Signed-off-by: Bhaskara Budiredla <bbudiredla@marvell.com>
> >> ---
> >>  drivers/mmc/core/Kconfig     |  14 ++-
> >>  drivers/mmc/core/Makefile    |   1 +
> >>  drivers/mmc/core/block.c     |  19 +++
> >>  drivers/mmc/core/block.h     |   9 ++
> >>  drivers/mmc/core/core.c      |  44 +++++++
> >>  drivers/mmc/core/mmcpstore.c | 227
> >+++++++++++++++++++++++++++++++++++
> >>  include/linux/mmc/core.h     |   5 +
> >>  include/linux/mmc/host.h     |  12 ++
> >>  8 files changed, 330 insertions(+), 1 deletion(-)  create mode 100644
> >> drivers/mmc/core/mmcpstore.c
> >>
> >> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig index
> >> c12fe13e4b14..4c651da4f2d2 100644
> >> --- a/drivers/mmc/core/Kconfig
> >> +++ b/drivers/mmc/core/Kconfig
> >> @@ -34,9 +34,22 @@ config PWRSEQ_SIMPLE
> >>           This driver can also be built as a module. If so, the module
> >>           will be called pwrseq_simple.
> >>
> >> +config MMC_PSTORE_BACKEND
> >> +       bool "Log panic/oops to a MMC buffer"
> >> +       depends on MMC_BLOCK
> >> +       help
> >> +         This option will let you create platform backend to store kmsg
> >> +         crash dumps to a user specified MMC device. This is primarily
> >> +         based on pstore/blk.
> >> +
> >> +config MMC_PSTORE
> >> +       tristate
> >> +       select PSTORE_BLK
> >> +
> >>  config MMC_BLOCK
> >>         tristate "MMC block device driver"
> >>         depends on BLOCK
> >> +       select MMC_PSTORE if MMC_PSTORE_BACKEND=y
> >>         default y
> >>         help
> >>           Say Y here to enable the MMC block device driver support.
> >> @@ -80,4 +93,3 @@ config MMC_TEST
> >>
> >>           This driver is only of interest to those developing or
> >>           testing a host driver. Most people should say N here.
> >> -
> >> diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
> >> index 95ffe008ebdf..7cb9a3af4827 100644
> >> --- a/drivers/mmc/core/Makefile
> >> +++ b/drivers/mmc/core/Makefile
> >> @@ -16,5 +16,6 @@ obj-$(CONFIG_PWRSEQ_EMMC)     += pwrseq_emmc.o
> >>  mmc_core-$(CONFIG_DEBUG_FS)    += debugfs.o
> >>  obj-$(CONFIG_MMC_BLOCK)                += mmc_block.o
> >>  mmc_block-objs                 := block.o queue.o
> >> +mmc_block-$(CONFIG_MMC_PSTORE) += mmcpstore.o
> >>  obj-$(CONFIG_MMC_TEST)         += mmc_test.o
> >>  obj-$(CONFIG_SDIO_UART)                += sdio_uart.o
> >> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> >> 42e27a298218..6592722cd7b2 100644
> >> --- a/drivers/mmc/core/block.c
> >> +++ b/drivers/mmc/core/block.c
> >> @@ -2870,6 +2870,21 @@ static void mmc_blk_remove_debugfs(struct
> >> mmc_card *card,
> >>
> >>  #endif /* CONFIG_DEBUG_FS */
> >>
> >> +#if IS_ENABLED(CONFIG_MMC_PSTORE)
> >> +sector_t mmc_blk_get_part(struct mmc_card *card, int part_num,
> >> +sector_t *size) {
> >> +       struct mmc_blk_data *md = dev_get_drvdata(&card->dev);
> >> +       struct gendisk *disk = md->disk;
> >> +       struct disk_part_tbl *part_tbl = disk->part_tbl;
> >> +
> >> +       if (part_num < 0 || part_num >= part_tbl->len)
> >> +               return 0;
> >> +
> >> +       *size = part_tbl->part[part_num]->nr_sects << SECTOR_SHIFT;
> >> +       return part_tbl->part[part_num]->start_sect;
> >> +}
> >> +#endif
> >> +
> >>  static int mmc_blk_probe(struct mmc_card *card)  {
> >>         struct mmc_blk_data *md, *part_md; @@ -2913,6 +2928,9 @@
> >> static int mmc_blk_probe(struct mmc_card *card)
> >>                         goto out;
> >>         }
> >>
> >> +       if (mmc_card_mmc(card) || mmc_card_sd(card))
> >> +               mmcpstore_card_set(card, md->disk->disk_name);
> >> +
> >>         /* Add two debugfs entries */
> >>         mmc_blk_add_debugfs(card, md);
> >>
> >> @@ -3060,6 +3078,7 @@ static void __exit mmc_blk_exit(void)
> >>         unregister_blkdev(MMC_BLOCK_MAJOR, "mmc");
> >>         unregister_chrdev_region(mmc_rpmb_devt, MAX_DEVICES);
> >>         bus_unregister(&mmc_rpmb_bus_type);
> >> +       unregister_mmcpstore();
> >>  }
> >>
> >>  module_init(mmc_blk_init);
> >> diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h index
> >> 31153f656f41..2a4ee5568194 100644
> >> --- a/drivers/mmc/core/block.h
> >> +++ b/drivers/mmc/core/block.h
> >> @@ -16,5 +16,14 @@ void mmc_blk_mq_recovery(struct mmc_queue
> >*mq);
> >> struct work_struct;
> >>
> >>  void mmc_blk_mq_complete_work(struct work_struct *work);
> >> +#if IS_ENABLED(CONFIG_MMC_PSTORE)
> >> +sector_t mmc_blk_get_part(struct mmc_card *card, int part_num,
> >> +sector_t *size); void mmcpstore_card_set(struct mmc_card *card, const
> >> +char *disk_name); void unregister_mmcpstore(void); #else static
> >> +inline void mmcpstore_card_set(struct mmc_card *card,
> >> +                                       const char *disk_name) {}
> >> +static inline void unregister_mmcpstore(void) {} #endif
> >>
> >>  #endif
> >> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> >> 19f1ee57fb34..7ad7ff1cab8c 100644
> >> --- a/drivers/mmc/core/core.c
> >> +++ b/drivers/mmc/core/core.c
> >> @@ -569,6 +569,30 @@ int mmc_cqe_recovery(struct mmc_host *host)  }
> >> EXPORT_SYMBOL(mmc_cqe_recovery);
> >>
> >> +#if IS_ENABLED(CONFIG_MMC_PSTORE)
> >> +/**
> >> + *     mmc_wait_for_pstore_req - initiate a blocking mmc request
> >> + *     @host: MMC host to start command
> >> + *     @mrq: MMC request to start
> >> + *
> >> + *     Start a blocking MMC request for a host and wait for the request
> >> + *     to complete that is based on polling and timeout.
> >> + */
> >> +void mmc_wait_for_pstore_req(struct mmc_host *host, struct
> >> +mmc_request *mrq) {
> >> +       unsigned int timeout;
> >> +
> >> +       host->ops->req_cleanup_pending(host);
> >> +       mmc_start_request(host, mrq);
> >> +
> >> +       if (mrq->data) {
> >> +               timeout = mrq->data->timeout_ns / NSEC_PER_MSEC;
> >> +               host->ops->req_completion_poll(host, timeout);
> >> +       }
> >> +}
> >> +EXPORT_SYMBOL(mmc_wait_for_pstore_req);
> >> +#endif
> >> +
> >>  /**
> >>   *     mmc_is_req_done - Determine if a 'cap_cmd_during_tfr' request is
> >done
> >>   *     @host: MMC host
> >> @@ -817,6 +841,26 @@ int __mmc_claim_host(struct mmc_host *host,
> >> struct mmc_ctx *ctx,  }  EXPORT_SYMBOL(__mmc_claim_host);
> >>
> >> +#if IS_ENABLED(CONFIG_MMC_PSTORE)
> >> +/**
> >> + *     mmc_claim_host_async - claim host in atomic context
> >> + *     @host: mmc host to claim
> >> + *
> >> + *     This routine may be called in panic/oops scenarios.
> >> + *     Return zero with host claim success, else busy status.
> >> + */
> >> +int mmc_claim_host_async(struct mmc_host *host) {
> >> +       if (!host->claimed && pm_runtime_active(mmc_dev(host))) {
> >> +               host->claimed = 1;
> >> +               return 0;
> >> +       }
> >> +
> >> +       return -EBUSY;
> >> +}
> >> +EXPORT_SYMBOL(mmc_claim_host_async);
> >> +#endif
> >> +
> >>  /**
> >>   *     mmc_release_host - release a host
> >>   *     @host: mmc host to release
> >> diff --git a/drivers/mmc/core/mmcpstore.c
> >> b/drivers/mmc/core/mmcpstore.c new file mode 100644 index
> >> 000000000000..f783ea215f18
> >> --- /dev/null
> >> +++ b/drivers/mmc/core/mmcpstore.c
> >> @@ -0,0 +1,227 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * MMC pstore support based on pstore/blk
> >> + *
> >> + * Copyright (c) 2020 Marvell.
> >> + * Author: Bhaskara Budiredla <bbudiredla@marvell.com>  */
> >> +
> >> +#define pr_fmt(fmt) "mmcpstore: " fmt
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/pstore_blk.h>
> >> +#include <linux/blkdev.h>
> >> +#include <linux/mount.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/mmc/mmc.h>
> >> +#include <linux/mmc/host.h>
> >> +#include <linux/mmc/card.h>
> >> +#include <linux/scatterlist.h>
> >> +#include "block.h"
> >> +#include "card.h"
> >> +#include "core.h"
> >> +
> >> +static struct mmcpstore_context {
> >> +       char dev_name[BDEVNAME_SIZE];
> >> +       int partno;
> >> +       sector_t start_sect;
> >> +       sector_t size;
> >> +       struct pstore_blk_config conf;
> >> +       struct pstore_blk_info info;
> >> +
> >> +       struct mmc_card *card;
> >> +       struct mmc_request *mrq;
> >> +} oops_cxt;
> >> +
> >> +static void mmc_prep_req(struct mmc_request *mrq,
> >> +               unsigned int sect_offset, unsigned int nsects,
> >> +               struct scatterlist *sg, u32 opcode, unsigned int
> >> +flags) {
> >> +       mrq->cmd->opcode = opcode;
> >> +       mrq->cmd->arg = sect_offset;
> >> +       mrq->cmd->flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> >> +
> >> +       if (nsects == 1) {
> >> +               mrq->stop = NULL;
> >> +       } else {
> >> +               mrq->stop->opcode = MMC_STOP_TRANSMISSION;
> >> +               mrq->stop->arg = 0;
> >> +               mrq->stop->flags = MMC_RSP_R1B | MMC_CMD_AC;
> >> +       }
> >> +
> >> +       mrq->data->blksz = SECTOR_SIZE;
> >> +       mrq->data->blocks = nsects;
> >> +       mrq->data->flags = flags;
> >> +       mrq->data->sg = sg;
> >> +       mrq->data->sg_len = 1;
> >> +}
> >> +
> >> +static int mmcpstore_panic_write_req(const char *buf,
> >> +               unsigned int nsects, unsigned int sect_offset) {
> >> +       struct mmcpstore_context *cxt = &oops_cxt;
> >> +       struct mmc_request *mrq = cxt->mrq;
> >> +       struct mmc_card *card = cxt->card;
> >> +       struct mmc_host *host = card->host;
> >> +       struct scatterlist sg;
> >> +       u32 opcode;
> >> +       int ret;
> >> +
> >> +       opcode = (nsects > 1) ? MMC_WRITE_MULTIPLE_BLOCK :
> >MMC_WRITE_BLOCK;
> >> +       mmc_prep_req(mrq, sect_offset, nsects, &sg, opcode,
> >MMC_DATA_WRITE);
> >> +       sg_init_one(&sg, buf, (nsects << SECTOR_SHIFT));
> >> +       mmc_set_data_timeout(mrq->data, cxt->card);
> >> +
> >> +       ret = mmc_claim_host_async(host);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       mmc_wait_for_pstore_req(host, mrq);
> >> +       return 0;
> >> +}
> >> +
> >> +static int mmcpstore_panic_write(const char *buf, sector_t off,
> >> +sector_t sects) {
> >> +       struct mmcpstore_context *cxt = &oops_cxt;
> >> +       int ret;
> >> +
> >> +       ret = mmcpstore_panic_write_req(buf, sects, cxt->start_sect + off);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static struct block_device *mmcpstore_open_backend(const char
> >> +*device) {
> >> +       struct block_device *bdev;
> >> +       dev_t devt;
> >> +
> >> +       bdev = blkdev_get_by_path(device, FMODE_READ, NULL);
> >> +       if (IS_ERR(bdev)) {
> >> +               devt = name_to_dev_t(device);
> >> +               if (devt == 0)
> >> +                       return ERR_PTR(-ENODEV);
> >> +
> >> +               bdev = blkdev_get_by_dev(devt, FMODE_READ, NULL);
> >> +               if (IS_ERR(bdev))
> >> +                       return bdev;
> >> +       }
> >> +
> >> +       return bdev;
> >> +}
> >> +
> >> +static void mmcpstore_close_backend(struct block_device *bdev) {
> >> +       if (!bdev)
> >> +               return;
> >> +       blkdev_put(bdev, FMODE_READ);
> >> +}
> >> +
> >> +void mmcpstore_card_set(struct mmc_card *card, const char *disk_name)
> >> +{
> >> +       struct mmcpstore_context *cxt = &oops_cxt;
> >> +       struct pstore_blk_config *conf = &cxt->conf;
> >> +       struct pstore_blk_info *info = &cxt->info;
> >> +       struct block_device *bdev;
> >> +       struct mmc_command *stop;
> >> +       struct mmc_command *cmd;
> >> +       struct mmc_request *mrq;
> >> +       struct mmc_data *data;
> >> +       int ret;
> >> +
> >> +       ret = pstore_blk_get_config(conf);
> >> +       if (!conf->device[0]) {
> >> +               pr_debug("psblk backend is empty\n");
> >> +               return;
> >> +       }
> >> +
> >> +       /* Multiple backend devices not allowed */
> >> +       if (cxt->dev_name[0])
> >> +               return;
> >> +
> >> +       bdev =  mmcpstore_open_backend(conf->device);
> >> +       if (IS_ERR(bdev)) {
> >> +               pr_err("%s failed to open with %ld\n",
> >> +                               conf->device, PTR_ERR(bdev));
> >> +               return;
> >> +       }
> >> +
> >> +       bdevname(bdev, cxt->dev_name);
> >> +       cxt->partno = bdev->bd_part->partno;
> >> +       mmcpstore_close_backend(bdev);
> >> +
> >> +       if (strncmp(cxt->dev_name, disk_name, strlen(disk_name)))
> >> +               return;
> >> +
> >> +       cxt->start_sect = mmc_blk_get_part(card, cxt->partno, &cxt->size);
> >> +       if (!cxt->start_sect) {
> >> +               pr_err("Non-existent partition %d selected\n", cxt->partno);
> >> +               return;
> >> +       }
> >> +
> >> +       /* Check for host mmc panic write polling function definitions */
> >> +       if (!card->host->ops->req_cleanup_pending ||
> >> +                       !card->host->ops->req_completion_poll)
> >> +               return;
> >> +
> >> +       cxt->card = card;
> >> +
> >> +       mrq = kzalloc(sizeof(struct mmc_request), GFP_KERNEL);
> >> +       if (!mrq)
> >> +               goto out;
> >> +
> >> +       cmd = kzalloc(sizeof(struct mmc_command), GFP_KERNEL);
> >> +       if (!cmd)
> >> +               goto free_mrq;
> >> +
> >> +       stop = kzalloc(sizeof(struct mmc_command), GFP_KERNEL);
> >> +       if (!stop)
> >> +               goto free_cmd;
> >> +
> >> +       data = kzalloc(sizeof(struct mmc_data), GFP_KERNEL);
> >> +       if (!data)
> >> +               goto free_stop;
> >> +
> >> +       mrq->cmd = cmd;
> >> +       mrq->data = data;
> >> +       mrq->stop = stop;
> >> +       cxt->mrq = mrq;
> >> +
> >> +       info->major = MMC_BLOCK_MAJOR;
> >> +       info->flags = PSTORE_FLAGS_DMESG;
> >> +       info->panic_write = mmcpstore_panic_write;
> >> +       ret = register_pstore_blk(info);
> >> +       if (ret) {
> >> +               pr_err("%s registering with psblk failed (%d)\n",
> >> +                               cxt->dev_name, ret);
> >> +               goto free_data;
> >> +       }
> >> +
> >> +       pr_info("%s registered as psblk backend\n", cxt->dev_name);
> >> +       return;
> >> +
> >> +free_data:
> >> +       kfree(data);
> >> +free_stop:
> >> +       kfree(stop);
> >> +free_cmd:
> >> +       kfree(cmd);
> >> +free_mrq:
> >> +       kfree(mrq);
> >> +out:
> >> +       return;
> >> +}
> >> +
> >> +void unregister_mmcpstore(void)
> >> +{
> >> +       struct mmcpstore_context *cxt = &oops_cxt;
> >> +
> >> +       unregister_pstore_blk(MMC_BLOCK_MAJOR);
> >> +       kfree(cxt->mrq->data);
> >> +       kfree(cxt->mrq->stop);
> >> +       kfree(cxt->mrq->cmd);
> >> +       kfree(cxt->mrq);
> >> +       cxt->card = NULL;
> >> +}
> >> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h index
> >> 29aa50711626..53840a361b5a 100644
> >> --- a/include/linux/mmc/core.h
> >> +++ b/include/linux/mmc/core.h
> >> @@ -166,6 +166,11 @@ struct mmc_request {
> >>
> >>  struct mmc_card;
> >>
> >> +#if IS_ENABLED(CONFIG_MMC_PSTORE)
> >> +void mmc_wait_for_pstore_req(struct mmc_host *host, struct
> >> +mmc_request *mrq); int mmc_claim_host_async(struct mmc_host *host);
> >> +#endif
> >> +
> >>  void mmc_wait_for_req(struct mmc_host *host, struct mmc_request
> >> *mrq);  int mmc_wait_for_cmd(struct mmc_host *host, struct
> >mmc_command *cmd,
> >>                 int retries);
> >> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h index
> >> 01bba36545c5..ba9001498e03 100644
> >> --- a/include/linux/mmc/host.h
> >> +++ b/include/linux/mmc/host.h
> >> @@ -178,6 +178,18 @@ struct mmc_host_ops {
> >>
> >>         /* Initialize an SD express card, mandatory for MMC_CAP2_SD_EXP. */
> >>         int     (*init_sd_express)(struct mmc_host *host, struct mmc_ios *ios);
> >> +
> >> +#if IS_ENABLED(CONFIG_MMC_PSTORE)
> >> +       /*
> >> +        * The following two APIs are introduced to support mmcpstore
> >> +        * functionality. Cleanup API to terminate the ongoing and
> >> +        * pending requests before a panic write post, and polling API
> >> +        * to ensure that write succeeds before the Kernel dies.
> >> +        */
> >> +       void    (*req_cleanup_pending)(struct mmc_host *host);
> >> +       int     (*req_completion_poll)(struct mmc_host *host,
> >> +                                      unsigned long timeout); #endif
> >>  };
> >>
> >>  struct mmc_cqe_ops {
> >> --
> >> 2.17.1
> >>
