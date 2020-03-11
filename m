Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6295181C66
	for <lists+linux-mmc@lfdr.de>; Wed, 11 Mar 2020 16:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgCKPfH (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 11 Mar 2020 11:35:07 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:33272 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbgCKPfF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Mar 2020 11:35:05 -0400
Received: by mail-vk1-f194.google.com with SMTP id i78so654267vke.0
        for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2020 08:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=90+4cbyvmZiwK+n8bqZwCG8fzd0Zc30j2fO2gboRTDk=;
        b=zRzh/Ir3A/Uy67VkNqMkJKCvikHR4AVoK5jAu6uGdGGzGzKGmB93kYWMhsh2hpoFrJ
         nlAIA0+IDxS9tf9Lzr18o8ooipk7BLbEGH9iQHEML8Tu5GE1WFHPCbN5Ysy9DvAdHRSd
         8aNGdTa77VNzFwGNk/5ipv4wT5e3TqlyDJpzcm51VCiLy9q9MEihMt+8V2Afs2nq5Iya
         Y0DtvlTEZUPclpWdJg927iVHsov5uTN3yn/HmaHCoHeDq/tH36couskeaSg6wFl1OCgQ
         ePiqZyalQ2xdeqBJE+WfVmOmpRxkxLDOYZW/aMfzxALIEk6R9GKj58F9Yk7hBNpaubFS
         Vulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=90+4cbyvmZiwK+n8bqZwCG8fzd0Zc30j2fO2gboRTDk=;
        b=S/79GTAuNG+mIw3+3WNSOP5z1GJJqS1oDtf/Hz7WiDQB8GacWbOb1/Q4T1gwX37crb
         IxqiOidYx9DfZxVeowDFohXrdlmoJ9XFsntFrqJiA3kBw3M9igZaQCoLur+pSPFXzyUL
         mRBwrv5M/7vJt8XqKnbepn0jegxQOXu0+DKR8c7oscrf2JjHSpMmEz5qXLds5iw4Kk72
         OYy6/ObkVSDAf5iVYL5+Fp66ksL5G6pU3VtXcXiTAxPAU34SvIQYcnWm9x1cOJqNOwU+
         kHcFXFH39muwDptUg43/zuHWfV1aznfSYb45p4cIvh+dRZ6IDrgwI31o3xuX34u9AXdS
         aCtA==
X-Gm-Message-State: ANhLgQ2vErsdCJz4csRNevJZiNWF0xzAu1Ro2sYwZXghUCerBj6i188v
        o6Ex0UzZ3PN+HwahnJ/pFMTsxA5WGCvtkgs1faRImw==
X-Google-Smtp-Source: ADFU+vsKcvA81UpBCqv5aEZtZcvbPIrwWVw/kgevw9ad+GWvv+a/Q8lcrLVFMiqmt3fz94FPL+a4Bnl+mYz9INjkAjI=
X-Received: by 2002:ac5:c4fc:: with SMTP id b28mr2365038vkl.101.1583940903582;
 Wed, 11 Mar 2020 08:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <1582890639-32072-1-git-send-email-vbadigan@codeaurora.org> <1583503724-13943-1-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1583503724-13943-1-git-send-email-vbadigan@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Mar 2020 16:34:27 +0100
Message-ID: <CAPDyKFrqijPjUmq9MCNap6WGV-LocB9zJ40v9hLY547QuPdJUg@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] Deactivate CQE during SDHC reset
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 6 Mar 2020 at 15:09, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> Host controllers can reset CQHCI either directly or as a consequence
> of host controller reset. In the later case, driver should deactivate
> CQHCI just before reset to puts the CQHCI driver into a state that is
> consistent with that h/w state.
>
> Changes sicne V2:
>         - Added support cqhci_deactivate()
>         - Use cqhci_deactivate() instead of cqhci_disable().
>         - Deactivate CQCHI just before SDHC reset.
>
> Changes since V1:
>         - Disable CQE only when SDHC undergoes s/w reset for all.
>
> Adrian Hunter (1):
>   mmc: cqhci: Add cqhci_deactivate()
>
> Veerabhadrarao Badiganti (1):
>   mmc: sdhci-msm: Deactivate CQE during SDHC reset
>
>  drivers/mmc/host/cqhci.c     | 6 +++---
>  drivers/mmc/host/cqhci.h     | 6 +++++-
>  drivers/mmc/host/sdhci-msm.c | 9 ++++++++-
>  3 files changed, 16 insertions(+), 5 deletions(-)

Applied for next, thanks!

Kind regards
Uffe
