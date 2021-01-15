Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0673C2F7529
	for <lists+linux-mmc@lfdr.de>; Fri, 15 Jan 2021 10:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbhAOJXX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 15 Jan 2021 04:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbhAOJXV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jan 2021 04:23:21 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A88EC061793
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jan 2021 01:22:41 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id o125so3378811vsc.6
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jan 2021 01:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1aoDhrmO29V6iY0iIzIjo0jf21Am5/IPUHSwR+jd+QU=;
        b=A+85xwb2j2pwVlBj1iFKyK/46CII/1Fs/XJI9gq2REDtGKV/VkcrkrruWAIni3h8PM
         g8h/aYCuOdjEAMjwdAPayyNfzu7NJHrp4er5qTuynptaXLjBXC52Ber5NTc0Y+GPVRJV
         vHOx9Eqq0vgiduJawnLSyeb2/WsyifYZvnadsSKkhmo22eGQSlmzRu7RmGCfpka8AeC6
         ZqLWKpIQQhOSwY5UGdgkKcI+iMkxVDE0xlDhBo73n1clt7UCYxuFa6LEsNIN3TF20FlT
         hbYcdmZwOou5k2h/4jogOV1CnX70Sg70erB/jJ3oMHLXU3j59Eu1KdmFxwl9Wve7tkth
         xPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1aoDhrmO29V6iY0iIzIjo0jf21Am5/IPUHSwR+jd+QU=;
        b=cF5QL/t35MiWfctCTgKq0UEz6d1LCvYVhhhogJLTMF8uvb2pavosljycXBs59qDJfc
         B0XQ2l+ibMfrDOPCazmRkLICsSi6kii+5ZEIi2wf0ffDqHfP7LWwiDB2etCBKhHQDuQ8
         7rmJk06InVo/RcdkfktNbffPsFBgrXcfKtoDi0OmE5KlhqRvi3RRwKoETAEQ36ely3J7
         iFm5SWhAAdni3N//bFsHjZq7XFBZEZ4C/U/Vz3UCjGWUB3U5W2BcPsP8X73VEKJQUKn4
         VdGSaaWUU0gY0fCWGJq28m1jabRuTmlRuPzhI87m16nGGbohZkavQOXzpR8n3JclP0Hq
         RqLg==
X-Gm-Message-State: AOAM533XLEM7PUwH9UjXncFF3d/S3/sPBQfCpxnUPYMHsHAC9lFUx028
        +eEe/aFGnDYa/SxzfDGTHOSt7yFT4GMDGvFKG9TVRQ==
X-Google-Smtp-Source: ABdhPJxNZr6Mg4MgyBmLCEff8QdhzBugcldCeAdEgNPQLj9KbGhnMTfhRS5corXljtL+XM2LNKkeNCu72rTaDYfxiEg=
X-Received: by 2002:a67:70c6:: with SMTP id l189mr9272009vsc.34.1610702559909;
 Fri, 15 Jan 2021 01:22:39 -0800 (PST)
MIME-Version: 1.0
References: <20210104184542.4616-1-ebiggers@kernel.org> <20210104184542.4616-2-ebiggers@kernel.org>
In-Reply-To: <20210104184542.4616-2-ebiggers@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 Jan 2021 10:22:03 +0100
Message-ID: <CAPDyKFq717teu2HPZLCn9QVxLOwZHdi_iS+Ji69S0kYX1o52PQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] mmc: add basic support for inline encryption
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-fscrypt@vger.kernel.org,
        Satya Tangirala <satyat@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neeraj Soni <neersoni@codeaurora.org>,
        Barani Muthukumaran <bmuthuku@codeaurora.org>,
        Peng Zhou <peng.zhou@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Konrad Dybcio <konradybcio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 4 Jan 2021 at 19:48, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> In preparation for adding CQHCI crypto engine (inline encryption)
> support, add the code required to make mmc_core and mmc_block aware of
> inline encryption.  Specifically:
>
> - Add a capability flag MMC_CAP2_CRYPTO to struct mmc_host.  Drivers
>   will set this if the host and driver support inline encryption.
>
> - Embed a blk_keyslot_manager in struct mmc_host.  Drivers will
>   initialize this if the host and driver support inline encryption.
>   mmc_block registers this keyslot manager with the request_queue of any
>   MMC card attached to the host.  mmc_core destroys this keyslot manager
>   when freeing the mmc_host.
>
> - Make mmc_block copy the crypto keyslot and crypto data unit number
>   from struct request to struct mmc_request, so that drivers will have
>   access to them.
>
> - If the MMC host is reset, reprogram all the keyslots to ensure that
>   the software state stays in sync with the hardware state.
>
> Co-developed-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Satya Tangirala <satyat@google.com>
> Reviewed-and-tested-by: Peng Zhou <peng.zhou@mediatek.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Eric, again, my apologies for the delay. Overall, I think this looks good.

My only hesitation to merge this as is, is that I want to make sure
you have thought of the life cycle issues for the struct
blk_keyslot_manager ksm. It's being used both from the mmc core/block
device driver and the mmc host driver. I am looking at this right now
and will get back to you very soon, if I find some issues with it.

If you have some time, feel free to elaborate around how this is
intended to work.

Kind regards
Uffe

> ---
>  drivers/mmc/core/Kconfig  |  8 ++++++
>  drivers/mmc/core/Makefile |  1 +
>  drivers/mmc/core/block.c  |  3 +++
>  drivers/mmc/core/core.c   |  3 +++
>  drivers/mmc/core/crypto.c | 54 +++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/crypto.h | 46 +++++++++++++++++++++++++++++++++
>  drivers/mmc/core/host.c   |  2 ++
>  drivers/mmc/core/queue.c  |  3 +++
>  include/linux/mmc/core.h  |  6 +++++
>  include/linux/mmc/host.h  |  7 +++++
>  10 files changed, 133 insertions(+)
>  create mode 100644 drivers/mmc/core/crypto.c
>  create mode 100644 drivers/mmc/core/crypto.h
>
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index c12fe13e4b147..ae8b69aee6190 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -81,3 +81,11 @@ config MMC_TEST
>           This driver is only of interest to those developing or
>           testing a host driver. Most people should say N here.
>
> +config MMC_CRYPTO
> +       bool "MMC Crypto Engine Support"
> +       depends on BLK_INLINE_ENCRYPTION

What about making this "default y" as well.


> +       help
> +         Enable Crypto Engine Support in MMC.
> +         Enabling this makes it possible for the kernel to use the crypto
> +         capabilities of the MMC device (if present) to perform crypto
> +         operations on data being transferred to/from the device.
> diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
> index 95ffe008ebdf8..6a907736cd7a5 100644
> --- a/drivers/mmc/core/Makefile
> +++ b/drivers/mmc/core/Makefile
> @@ -18,3 +18,4 @@ obj-$(CONFIG_MMC_BLOCK)               += mmc_block.o
>  mmc_block-objs                 := block.o queue.o
>  obj-$(CONFIG_MMC_TEST)         += mmc_test.o
>  obj-$(CONFIG_SDIO_UART)                += sdio_uart.o
> +mmc_core-$(CONFIG_MMC_CRYPTO)  += crypto.o
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 42e27a2982180..b877f62df3660 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -51,6 +51,7 @@
>  #include "block.h"
>  #include "core.h"
>  #include "card.h"
> +#include "crypto.h"
>  #include "host.h"
>  #include "bus.h"
>  #include "mmc_ops.h"
> @@ -1247,6 +1248,8 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
>
>         memset(brq, 0, sizeof(struct mmc_blk_request));
>
> +       mmc_crypto_prepare_req(mqrq);
> +
>         brq->mrq.data = &brq->data;
>         brq->mrq.tag = req->tag;
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 19f1ee57fb345..bd4b557e68899 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -37,6 +37,7 @@
>
>  #include "core.h"
>  #include "card.h"
> +#include "crypto.h"
>  #include "bus.h"
>  #include "host.h"
>  #include "sdio_bus.h"
> @@ -992,6 +993,8 @@ void mmc_set_initial_state(struct mmc_host *host)
>                 host->ops->hs400_enhanced_strobe(host, &host->ios);
>
>         mmc_set_ios(host);
> +
> +       mmc_crypto_set_initial_state(host);
>  }
>
>  /**
> diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
> new file mode 100644
> index 0000000000000..4f47eb4740db0
> --- /dev/null
> +++ b/drivers/mmc/core/crypto.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MMC crypto engine (inline encryption) support
> + *
> + * Copyright 2020 Google LLC
> + */
> +
> +#include <linux/blk-crypto.h>
> +#include <linux/mmc/host.h>
> +
> +#include "core.h"
> +#include "crypto.h"
> +#include "queue.h"
> +
> +void mmc_crypto_set_initial_state(struct mmc_host *host)
> +{
> +       /* Reset might clear all keys, so reprogram all the keys. */
> +       if (host->caps2 & MMC_CAP2_CRYPTO)
> +               blk_ksm_reprogram_all_keys(&host->ksm);
> +}
> +
> +void mmc_crypto_free_host(struct mmc_host *host)
> +{
> +       if (host->caps2 & MMC_CAP2_CRYPTO)
> +               blk_ksm_destroy(&host->ksm);
> +}
> +
> +void mmc_crypto_setup_queue(struct request_queue *q, struct mmc_host *host)
> +{
> +       if (host->caps2 & MMC_CAP2_CRYPTO)
> +               blk_ksm_register(&host->ksm, q);
> +}
> +EXPORT_SYMBOL_GPL(mmc_crypto_setup_queue);
> +
> +void mmc_crypto_prepare_req(struct mmc_queue_req *mqrq)
> +{
> +       struct request *req = mmc_queue_req_to_req(mqrq);
> +       struct mmc_request *mrq = &mqrq->brq.mrq;
> +
> +       if (!req->crypt_keyslot)
> +               return;
> +
> +       mrq->crypto_enabled = true;
> +       mrq->crypto_key_slot = blk_ksm_get_slot_idx(req->crypt_keyslot);
> +
> +       /*
> +        * For now we assume that all MMC drivers set max_dun_bytes_supported=4,
> +        * which is the limit for CQHCI crypto.  So all DUNs should be 32-bit.
> +        */
> +       WARN_ON_ONCE(req->crypt_ctx->bc_dun[0] > U32_MAX);
> +
> +       mrq->data_unit_num = req->crypt_ctx->bc_dun[0];
> +}
> +EXPORT_SYMBOL_GPL(mmc_crypto_prepare_req);
> diff --git a/drivers/mmc/core/crypto.h b/drivers/mmc/core/crypto.h
> new file mode 100644
> index 0000000000000..4780639b832f4
> --- /dev/null
> +++ b/drivers/mmc/core/crypto.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * MMC crypto engine (inline encryption) support
> + *
> + * Copyright 2020 Google LLC
> + */
> +
> +#ifndef _MMC_CORE_CRYPTO_H
> +#define _MMC_CORE_CRYPTO_H
> +
> +struct mmc_host;
> +struct mmc_queue_req;
> +struct request_queue;
> +
> +#ifdef CONFIG_MMC_CRYPTO
> +
> +void mmc_crypto_set_initial_state(struct mmc_host *host);
> +
> +void mmc_crypto_free_host(struct mmc_host *host);
> +
> +void mmc_crypto_setup_queue(struct request_queue *q, struct mmc_host *host);
> +
> +void mmc_crypto_prepare_req(struct mmc_queue_req *mqrq);
> +
> +#else /* CONFIG_MMC_CRYPTO */
> +
> +static inline void mmc_crypto_set_initial_state(struct mmc_host *host)
> +{
> +}
> +
> +static inline void mmc_crypto_free_host(struct mmc_host *host)
> +{
> +}
> +
> +static inline void mmc_crypto_setup_queue(struct request_queue *q,
> +                                         struct mmc_host *host)
> +{
> +}
> +
> +static inline void mmc_crypto_prepare_req(struct mmc_queue_req *mqrq)
> +{
> +}
> +
> +#endif /* !CONFIG_MMC_CRYPTO */
> +
> +#endif /* _MMC_CORE_CRYPTO_H */
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 96b2ca1f1b06d..d962b9ca0e37a 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -25,6 +25,7 @@
>  #include <linux/mmc/slot-gpio.h>
>
>  #include "core.h"
> +#include "crypto.h"
>  #include "host.h"
>  #include "slot-gpio.h"
>  #include "pwrseq.h"
> @@ -532,6 +533,7 @@ EXPORT_SYMBOL(mmc_remove_host);
>   */
>  void mmc_free_host(struct mmc_host *host)
>  {
> +       mmc_crypto_free_host(host);
>         mmc_pwrseq_free(host);
>         put_device(&host->class_dev);
>  }
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index de7cb0369c308..d96db852bb91a 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -19,6 +19,7 @@
>  #include "block.h"
>  #include "core.h"
>  #include "card.h"
> +#include "crypto.h"
>  #include "host.h"
>
>  #define MMC_DMA_MAP_MERGE_SEGMENTS     512
> @@ -405,6 +406,8 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>         mutex_init(&mq->complete_lock);
>
>         init_waitqueue_head(&mq->wait);
> +
> +       mmc_crypto_setup_queue(mq->queue, host);
>  }
>
>  static inline bool mmc_merge_capable(struct mmc_host *host)
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 29aa507116261..ab19245e99451 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -162,6 +162,12 @@ struct mmc_request {
>         bool                    cap_cmd_during_tfr;
>
>         int                     tag;
> +
> +#ifdef CONFIG_MMC_CRYPTO
> +       bool                    crypto_enabled;
> +       int                     crypto_key_slot;
> +       u32                     data_unit_num;
> +#endif
>  };
>
>  struct mmc_card;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 01bba36545c54..6f86948f92caf 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -15,6 +15,7 @@
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/pm.h>
>  #include <linux/dma-direction.h>
> +#include <linux/keyslot-manager.h>
>
>  struct mmc_ios {
>         unsigned int    clock;                  /* clock rate */
> @@ -384,6 +385,7 @@ struct mmc_host {
>  #define MMC_CAP2_CQE_DCMD      (1 << 24)       /* CQE can issue a direct command */
>  #define MMC_CAP2_AVOID_3_3V    (1 << 25)       /* Host must negotiate down from 3.3V */
>  #define MMC_CAP2_MERGE_CAPABLE (1 << 26)       /* Host can merge a segment over the segment size */
> +#define MMC_CAP2_CRYPTO                (1 << 27)       /* Host supports inline encryption */
>
>         int                     fixed_drv_type; /* fixed driver type for non-removable media */
>
> @@ -478,6 +480,11 @@ struct mmc_host {
>         bool                    cqe_enabled;
>         bool                    cqe_on;
>
> +       /* Inline encryption support */
> +#ifdef CONFIG_MMC_CRYPTO
> +       struct blk_keyslot_manager ksm;
> +#endif
> +
>         /* Host Software Queue support */
>         bool                    hsq_enabled;
>
> --
> 2.30.0
>
