Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B55CFA9EEB
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Sep 2019 11:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbfIEJxq (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Sep 2019 05:53:46 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34489 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731058AbfIEJxq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2019 05:53:46 -0400
Received: by mail-qk1-f193.google.com with SMTP id q203so1525111qke.1
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2019 02:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dH6c47o1bqW0T/VDO/DwsdyvGbN/LKQ+TVfqPRq30KM=;
        b=LARva/AOlGtskecJn49i4atzPRksvRQPNLCJwb+qXUACmQCqPeDD2+uSZDzW9cIPZf
         OkuYVI9QoRHHOJAzgKQeqq0CYps25cmRlNV4N5O1iuYSWbNuDAXklgmO5ubGf0LZEGBV
         kfxHK8lZzsAWpm/2M23X6OKkNnmL271Fm3dPquf9JcOW9Roru2sASxDR/vYVCFkTG4xg
         CxBaz3cnCZR7MUfOOdjlqnlWD2vhX1YYBDJPVA1GKCGp/l5Wn4vU+/86raKn3UG0iL6S
         Exjh26QDxsSjdOQPV/b9NJ67vxDWAeLr6mZ4ZrmA1RkGPHl9/mFKg1RlIkK+svRmTNP2
         8+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dH6c47o1bqW0T/VDO/DwsdyvGbN/LKQ+TVfqPRq30KM=;
        b=o1MSHXUEt50pRtpHobauk8ua1xxVOqRywukUuBp0V9C/UP0xJ28NiaOQv33n6NXrBQ
         Z+KeCKEOVZTiKlDsMw2oQGMxmuNLwH/97iz+TwiT4TWcI13bGXwUay9+ybVyLxRAN2NL
         1fjAWT6n2SgEFQi0/9l/5l8c3crE1lQ08OmXb0oCnfr191k652VEJOpmUUfDbpu2ZNIh
         BPx6gdhb29YLQixO7cxpUKQhoQrqTv7PNObKEAw/HIl9TwyAHelxkrVKD/t8CTlTaXRr
         vmTiW0DAsJRWEexP40tt6qDuFv1Bt3ZTscyL+cTD6aBv7NuS/bQaIAKY9HmvEhLqvPzt
         RIXA==
X-Gm-Message-State: APjAAAVWaS1fWqfUMA78/Mo40/qaTNYRKtTaUv/nqfY7MiHEUGr9XRph
        aD21wWue0Wz8Ix2CDzC+/6scqgM0bCRBHTXhE6/1DQ==
X-Google-Smtp-Source: APXvYqy2RcJgNErkLRhk6vGyqNEsVyaAE5kDDf9FWZN8cjfsKkhmOcT0s9Xw/KepD2nJ2lF4odiYxQPN8qRhlnzK3YI=
X-Received: by 2002:a37:883:: with SMTP id 125mr1807511qki.478.1567677225577;
 Thu, 05 Sep 2019 02:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <CH2PR16MB3479DFF5DE7E598252E76CC4E5BB0@CH2PR16MB3479.namprd16.prod.outlook.com>
In-Reply-To: <CH2PR16MB3479DFF5DE7E598252E76CC4E5BB0@CH2PR16MB3479.namprd16.prod.outlook.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Thu, 5 Sep 2019 17:53:34 +0800
Message-ID: <CAD8Lp45V8exPbQjO4+xmQO7kHGKKt=vzjU_ynBiwzJPosSnpcQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: sdhci: Remove unneeded quirk2 flag of O2 SD
 host controller"
To:     "Ernest Zhang(WH)" <ernest.zhang@bayhubtech.com>
Cc:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux@endlessm.com" <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Sep 5, 2019 at 5:33 PM Ernest Zhang(WH)
<ernest.zhang@bayhubtech.com> wrote:
> Hi Daniel,
>         I suggestion that you set PCR(PCI Configuration Register) 0x308 bit4 to 1 before load module " sdhci_pci " then test again.
>         For support 1.8V eMMC chip better, I had submit some patches to Linux kernel.  But these patches are only work when PCR 0x308 bit4 is 1.

Writes to this register seem to be ignored. I tried 8 bit, 16 bit and
32 bit access, using the setpci command, and I wasn't able to change
any of the bits.
The 32 bit value at this address has value 0x01000800 and as it seems
to be read-only I'm unable to follow your suggestion.

Daniel
