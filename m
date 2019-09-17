Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A84FB4F16
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Sep 2019 15:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfIQNZE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Sep 2019 09:25:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34414 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfIQNZE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Sep 2019 09:25:04 -0400
Received: by mail-lf1-f67.google.com with SMTP id r22so2914304lfm.1
        for <linux-mmc@vger.kernel.org>; Tue, 17 Sep 2019 06:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jnmb4XCwm5+hoE4RzVuISq1bLHtPXM3ASR1GKaav0Lc=;
        b=NEhYd8kCpWRlM9SpfyraQACRGBQCnhJfzf3e5jfCT3CfC3oSnxwoW7xcFCheDX5XX7
         4H0xBGt258UPjKjHLiBhhkwUxriiKSO96dFhMd+LZ1rDBZITs3GBvQq709mVjhy0CfXQ
         CYD2l1tz8t+v7nS+ZZ+ZVQCPBF/r1V+0zjOXD8UpAUv6M5RJcRoMUTG/RvYGWI9VnqKS
         eU0Q3oFc28Myo5XJBWeqASPs0qIFiXOwFlOHUDcok7DjxJZDt9yWWIAqBBr5ahu4DKiM
         H+cze+dUIwYc6XCz4GfOofxoIMMGUjVD85uwy2dgnay2fIb4/8QrVdTh3BTzwr2IlqHq
         CRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jnmb4XCwm5+hoE4RzVuISq1bLHtPXM3ASR1GKaav0Lc=;
        b=YqAeMngwnV/+WBcWfaR9Jym8Xb72iSrbfUTwtrQHlxPqyP3qebvE8WSgSOFZ5zs4cD
         WbzFrmQS1MF2QNw/PAzyQucW9TwqNaTH1IgDVPomCc+5m6BVRmxS0TxQ/OXRkiXpdMlv
         CU80Ue53eUgAJ38cZNN+f2VSWtjbOSNZhPLoJ0R80xKhJr5NnlBIRpFw9P6xO2yZ7YfT
         Uo8RCD3VcCZEeLJ++cHIb+CJnzgoxOw4ySvDCLLAaqgq+a8+AftfqfnJL2GtpM+fVFqz
         1bGSHXKdwWs1RKuuA7crDXhbfNqaJed/vGIvJ6h0ySZUk+hrXWN86GLrjAeFepCFTRr+
         YvKw==
X-Gm-Message-State: APjAAAWPeHu7Aa0a0mofBfsr3+L0TJEO/NkgFqUw2Xn5qHSJqOrvPOM4
        2cWUC7DhnonrjDq21GCtNomqGKqJ/Nk/O80KI2iafqbjqp4=
X-Google-Smtp-Source: APXvYqy/5kMndWQ+BXE9NO4jUYAyx7La4UeW2AzH16XT0MFoyeiEfqsQxINgSCz60jCiyetFuOOnMS4FmbbY+VBHANA=
X-Received: by 2002:a19:6556:: with SMTP id c22mr2095064lfj.90.1568726700979;
 Tue, 17 Sep 2019 06:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190916171509.GG25745@shell.armlinux.org.uk> <b19a0640-5d71-a005-eb0f-c6840f181e5d@free.fr>
 <20190917081931.GI25745@shell.armlinux.org.uk> <20190917104200.GJ25745@shell.armlinux.org.uk>
 <20190917111631.GL25745@shell.armlinux.org.uk> <20190917114210.GM25745@shell.armlinux.org.uk>
 <20190917123326.GN25745@shell.armlinux.org.uk> <20190917130759.GO25745@shell.armlinux.org.uk>
In-Reply-To: <20190917130759.GO25745@shell.armlinux.org.uk>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 17 Sep 2019 10:24:57 -0300
Message-ID: <CAOMZO5DXv8g5qTGdvobDdLWim+tW=vK4+K=P-VqJK23KERMhJw@mail.gmail.com>
Subject: Re: [REGRESSION] sdhci no longer detects SD cards on LX2160A
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        dann frazier <dann.frazier@canonical.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Russell,

On Tue, Sep 17, 2019 at 10:10 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:

> Will suggested reverting bd2e75633c80 ("dma-contiguous: use fallback
> alloc_pages for single pages") which has been implicated in the same
> problem here:
>
> https://www.spinics.net/lists/arm-kernel/msg750623.html

It seems that the final fix was:
https://lore.kernel.org/patchwork/patch/1121600/

Does it work for you if we follow the same idea?

--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1105,6 +1105,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)

        esdhc_init(pdev, host);

+       sdhci_enable_v4_mode(host);
        sdhci_get_of_property(pdev);

        pltfm_host = sdhci_priv(host);
