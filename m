Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C60E78A875
	for <lists+linux-mmc@lfdr.de>; Mon, 28 Aug 2023 11:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjH1JFy (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 28 Aug 2023 05:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjH1JFd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Aug 2023 05:05:33 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE405102
        for <linux-mmc@vger.kernel.org>; Mon, 28 Aug 2023 02:05:30 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d743a5fe05aso2834744276.2
        for <linux-mmc@vger.kernel.org>; Mon, 28 Aug 2023 02:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693213530; x=1693818330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J1RNMza/FYgHvj33jNjozA6gVKX8HFlv5PptHiwW4FU=;
        b=d2aQfYsK32hUyp2Yu5cXAdJwNM7w09dyAa694IhAP449GN90ljg8UT03FZtYOHTkNe
         0u/2vxFEiJTKr/tgpGfqFTAhyC0XRo1s0FRs45HRvNbVsSaMc0qfwLSg7VEou9TFparr
         Hx4FXLlxnvbRbdx7G28RosE9WH4wbT6rT5BMxAuQcs5510Q0kYwew0iNmxj6EMkWSzJ/
         XkMb1yZKN/sNq+mGq5nh7NoAmBZBfip9mQeteFqDFLqf6G65w6vUuhLiD9QEY3mE6bLa
         Szcu5EB2I38TgAp0hXGn8Co0k0oODnhqI13xoG8zIVAXNkSb2FZT3CAXar5F/v+emPur
         KfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693213530; x=1693818330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1RNMza/FYgHvj33jNjozA6gVKX8HFlv5PptHiwW4FU=;
        b=M4/sigxIgEz7DPISi33Y6PG3OYn3lqMTS6z30HBz4KyJ+igUBi/vxET4O/FYwgGFRo
         WEKFKkKeU+Ir7q/hbh74XOPmB5ln8DxM+Vr/zEVD23VNOdh5JRzi1jeLdMhNZhbo6Vkt
         5bbbsky0Hoec8WdkQol8Dy6ik/VC6Cg1OSR0bQvSEdZJeRLh+/EMZg/nZakn9EZ0dDFm
         6T9FrLchdMhMUSRTCIvQ1WbFsjZrGZg5b6+ifDphZUeXWnAmpddS+2n7KRoCOrqgLeuZ
         LRVDA95eW2XeNWgrQKhr3u3HYGnEozWndq3IkA5Sul/2avnjkHLzGX1w+0ftGKtjbDr5
         sCkA==
X-Gm-Message-State: AOJu0YzmYTCgao7jmWwIv9UfYOL4qNe2k9QRqHzU8Xobi8QjZwFqMElt
        udiRK93ruoXW3CVF+tKCStQoGc7AMMVSEe+SmS6jjdqaVm2BFz/fGzE=
X-Google-Smtp-Source: AGHT+IHq+aJHFLWI8UMIwAM1r5QOuuXEt5p+X5yVlU5MKm+roaUxdv6D3/izv+QX8vHNDmiY/hXGs6MNYvsLy/6tvqs=
X-Received: by 2002:a25:23c6:0:b0:d7a:bfcf:2d3 with SMTP id
 j189-20020a2523c6000000b00d7abfcf02d3mr5069144ybj.51.1693213530110; Mon, 28
 Aug 2023 02:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <769a67cb-1b32-fd4f-b37e-e3ec4dab5eb9@rock-chips.com>
 <20230826162635.617-1-Sharp.Xia@mediatek.com> <95e9525e-3101-4433-27e2-cd69f254af1c@rock-chips.com>
In-Reply-To: <95e9525e-3101-4433-27e2-cd69f254af1c@rock-chips.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Aug 2023 11:04:54 +0200
Message-ID: <CAPDyKFqgQmvdmXe8Sxnv2E5EY9cose+E2pBK3r0P_OzqAC79dg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: Set optimal I/O size when mmc_setip_queue
To:     sharp.xia@mediatek.com, Shawn Lin <shawn.lin@rock-chips.com>
Cc:     angelogioacchino.delregno@collabora.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        matthias.bgg@gmail.com, wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 28 Aug 2023 at 04:28, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Hi Sharp
>
> On 2023/8/27 0:26, Sharp.Xia@mediatek.com wrote:
> > On Fri, 2023-08-25 at 17:17 +0800, Shawn Lin wrote:
> >>
> >>
>
> After more testing, most of my platforms which runs at HS400/HS200 mode
> shows nearly no differences with the readahead ranging from 128 to 1024.
> Yet just a board shows a performance drop now. Highly suspect it's eMMC
> chip depends. I would recommand leave it to the BSP guys to decide which
> readahead value is best for their usage.

That's a very good point. The SD/eMMC card certainly behaves
differently, depending on the request-size.

Another thing we could consider doing, could be to combine the
information about the request-size from the mmc host, with some
relevant information from the registers in the card (not sure exactly
what though).

>
> >
> > I tested with RK3568 and sdhci-of-dwcmshc.c driver, the performance improved by 2~3%.
> >
> > Before:
> > root@OpenWrt:/mnt/mmcblk0p3# time dd if=test.img of=/dev/null
> > 2097152+0 records in
> > 2097152+0 records out
> > real    0m 6.01s
> > user    0m 0.84s
> > sys     0m 2.89s
> > root@OpenWrt:/mnt/mmcblk0p3# cat /sys/block/mmcblk0/queue/read_ahead_kb
> > 128
> >
> > After:
> > root@OpenWrt:/mnt/mmcblk0p3# echo 3 > /proc/sys/vm/drop_caches
> > root@OpenWrt:/mnt/mmcblk0p3# time dd if=test.img of=/dev/null
> > 2097152+0 records in
> > 2097152+0 records out
> > real    0m 5.86s
> > user    0m 1.04s
> > sys     0m 3.18s
> > root@OpenWrt:/mnt/mmcblk0p3# cat /sys/block/mmcblk0/queue/read_ahead_kb
> > 1024
> >
> > root@OpenWrt:/sys/kernel/debug/mmc0# cat ios
> > clock:          200000000 Hz
> > actual clock:   200000000 Hz
> > vdd:            18 (3.0 ~ 3.1 V)
> > bus mode:       2 (push-pull)
> > chip select:    0 (don't care)
> > power mode:     2 (on)
> > bus width:      3 (8 bits)
> > timing spec:    9 (mmc HS200)
> > signal voltage: 1 (1.80 V)
> > driver type:    0 (driver type B)
> >

Thanks for testing and sharing the data, both of you!

Kind regards
Uffe
