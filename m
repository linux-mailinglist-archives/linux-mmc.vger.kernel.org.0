Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63EF86F815
	for <lists+linux-mmc@lfdr.de>; Mon, 22 Jul 2019 05:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfGVDps (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 21 Jul 2019 23:45:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33464 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfGVDps (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Jul 2019 23:45:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so18471271plo.0
        for <linux-mmc@vger.kernel.org>; Sun, 21 Jul 2019 20:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=Q+CprcBWNGzzOj+Sw0vKnMQfxVeanS+db7YYJpzou7g=;
        b=WDL9xskU+6mR1xv+y4xPQgtjDgEl42buTCy0YnscHHfEoCURUcnRXD9wWYekVSf1o5
         CEaC5Z63V1T4J1HPn2loWFdyHQ188qOC8HTE1tCkgsxm0DgBIbM+wwiRATS/gxf19VBD
         f3xZ1eTzKoRZllbakeQkmMhdN97odGA/p3E9FEUNig48FfkGfyGNshrP9T7RfuxOtTPb
         JzQe8I+ETuzmXaP+wLSAgfQz8ClgKnFulThfncZZgdUXZFIs9ks4d2zoJ7c82c9nT1/1
         +1zVc8Z3jT0sKEoHnkcbnvl5QDyOwNbpsjlFcIVOLuO7oaJH1miFwmWdWerZVIjSMh+o
         Vp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=Q+CprcBWNGzzOj+Sw0vKnMQfxVeanS+db7YYJpzou7g=;
        b=CKqkKRmawD81ZzBFdqEZmUACRCerWeYynEWAbb3AHJlkzvq2Nb/28RG9S6+evnINMs
         eUf282/8vTVunig1ae2U3DsFWK+9ZUsgy/wjsA6+9dFImMxpQGrMvCpxGnsXM+WbArut
         8dWArUlpmsjYTvVtD8rPVySGJBT+BqR1OXH8Js1aM1b8C+lLnEqcZosEySM2TJdxtSvU
         x6AzfrXg6JfYNgEvDlOOzRwENXSM0OFze4+vecs4P+JIhJW/rNqNUJAK2nsIgQDMKZXX
         DjfEIaceP9UeDj3O8CQ+Aik6T5HcvEscMFyOnllIh/LQYZOeqRqHhy1vTcgbkB/Rrrva
         pHbA==
X-Gm-Message-State: APjAAAXuXzFlQxIVQKghox98lpFTNAlQ3qIM1doV31cdPQvQAcjotfDS
        Ork8gQf9Uwm28Plmi6+sTMAtzw==
X-Google-Smtp-Source: APXvYqzmRe20/h+24P6SPjfzMTRITn4vZ1GwTUD39dSQj7SEx26SlX9FLHuarhjDu/PCHYr6S9fLgw==
X-Received: by 2002:a17:902:8489:: with SMTP id c9mr73747177plo.327.1563767147759;
        Sun, 21 Jul 2019 20:45:47 -0700 (PDT)
Received: from localhost.localdomain (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id i9sm31089595pjj.2.2019.07.21.20.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Jul 2019 20:45:47 -0700 (PDT)
From:   shihpo.hung@sifive.com
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Andreas Koop <andreas.koop@zf.com>, linux-mmc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 1/1] mmc: mmc_spi: Enable stable writes
Date:   Mon, 22 Jul 2019 11:45:14 +0800
Message-Id: <1563767114-22036-1-git-send-email-shihpo.hung@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <4D4D24CE952D2A4684FC7FAAEF13D7164BE076@DLNV00136.emea.zf-world.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 23 Oct 2013, Andreas wrote:
> Hello,
> 
> While using the mmc_spi driver occasionally errors like this popped up:
> 
> mmcblk0: error -84 transferring data
> end_request: I/O error, dev mmcblk0, sector 581756
> 
> I looked on the Internet for occurences of the same problem and came across a helpful post [1]. It includes source code to reproduce the bug. There is also an analysis about the cause. During transmission data in the supplied buffer is beeing modified. Thus the previously calculated check sum is not correct anymore.
> 
> After some digging I found out that device drivers are supposed to report they need stable writes.  To fix this I set the appropriate flag at queue initialization if CRC checksumming is enabled for that SPI host.
> 
> [1]
> https://groups.google.com/forum/#!msg/sim1/gLlzWeXGFr8/KevXinUXfc8J
> 
> Signed-off-by: Andreas Koop <andreas.koop <at> zf.com>
> ---
> --
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index fa9632e..3fdef37 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -207,6 +207,9 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
>  	mq->mqrq_prev = mqrq_prev;
>  	mq->queue->queuedata = mq;
>  
> +	if (mmc_host_is_spi(host) && host->use_spi_crc)
> +		mq->queue->backing_dev_info.capabilities |= BDI_CAP_STABLE_WRITES;
> +
>  	blk_queue_prep_rq(mq->queue, mmc_prep_request);
>  	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, mq->queue);
>  	if (mmc_can_erase(card))

Tested-by: ShihPo Hung <shihpo.hung@sifive.com>

Although this is an old patch, I encountered the same problem which could be fixed by it.

On Hifive Unleashed board (a multicore environment), running LTP fcntl36
with /tmp located on /dev/mmcblk could trigger ILSEQ in mmc_spi_writeblock()
and then cause mmc device removed.

Error log:
  tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
  fcntl36.c:304: INFO: OFD read lock vs OFD write lock
  fcntl36.c:382: PASS: Access between threads synchronized
  fcntl36.c:304: INFO: OFD write lock vs POSIX write lock
  fcntl36.c:382: PASS: Access between threads synchronized
  fcntl36.c:304: INFO: OFD read lock vs POSIX write lock
  mmc0: SPI card removed
  EXT4-fs warning (device mmcblk0p2): ext4_end_bio:323: I/O error 10
  Buffer I/O error on device mmcblk0p2, logical block 1084426
  EXT4-fs warning (device mmcblk0p2): ext4_end_bio:323: I/O error 10
  Buffer I/O error on device mmcblk0p2, logical block 1084427
  EXT4-fs warning (device mmcblk0p2): ext4_end_bio:323: I/O error 10
  Buffer I/O error on device mmcblk0p2, logical block 2129920
  EXT4-fs warning (device mmcblk0p2): ext4_end_bio:323: I/O error 10
  Buffer I/O error on device mmcblk0p2, logical block 1082369
  EXT4-fs warning (device mmcblk0p2): ext4_end_bio:323: I/O error 10
  Buffer I/O error on device mmcblk0p2, logical block 1084941
  Buffer I/O error on device mmcblk0p2, logical block 1084942
  Buffer I/O error on device mmcblk0p2, logical block 1084943
  Buffer I/O error on device mmcblk0p2, logical block 1084944
  Buffer I/O error on device mmcblk0p2, logical block 1084945
  Buffer I/O error on device mmcblk0p2, logical block 1084946

The problem is that the data page is dirty again while it is in the
process of writeback, then the CRC calculated by mmc_spi_writeblock()
is not valid.

I would like to send a v2 which rebases this patch on v5.3-rc1 to help
it upstream.
