Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAA633178
	for <lists+linux-mmc@lfdr.de>; Mon,  3 Jun 2019 15:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfFCNtK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 3 Jun 2019 09:49:10 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46795 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbfFCNtF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Jun 2019 09:49:05 -0400
Received: by mail-vs1-f67.google.com with SMTP id l125so11206662vsl.13
        for <linux-mmc@vger.kernel.org>; Mon, 03 Jun 2019 06:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVPjgUEfaRYGNEU+1OBxoG2swQn44QuLIgwlXfuk4Mc=;
        b=aYWK0MbZzIOtT3h65I4XJFM1XyeTSum8bGZutJ6oGT+Ni7GT9hHM/wfxqLCtoUDEmz
         01VmV7kH08fTkH/cC2Xum0TjARU7c22W3r0YBbrRz1rhtm3fLf2/vAbxYU3Zua/OoGfj
         vU6SQZ+elZ9/4lQ5MHacYqRAEYs40n3qWu3ZYETOrZw+JLU0voeoEKN6uZbfo0wTkKpO
         PRQ3FfocXTArfHf8OjD3THxG4uZEZp7IwmNGMDJllryNwqtntIuespOEotcJqLAgxgjz
         Ze6HbmK06EGye6vofym0sxQCcv12KR23LE7BH4/DR8cUKos02+qELuBK/nrQqVYRb+rJ
         r5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVPjgUEfaRYGNEU+1OBxoG2swQn44QuLIgwlXfuk4Mc=;
        b=RMaBNnSTVQdJrHRf/LhUJHbQQWyAN8Mm+CEvLJEaxQH24OysolWsnalmGu+W/mrq3Y
         GaUfDqlufbGQ4LTW4bAX4+JgRAKVmfruOmTo9zVU3PS3x+dvhoNOs8uYZSp09DwJfEG6
         tt0QUYo7l42smjtnh2uSr0lXUvsHK59eVTLwoELhXBMnsyPSAjavTgW3KvC3BOTsZgOb
         Hye/prOWFM0RzMfJ9dx35ixhv5hLV7hBEro0pCh6awPkY3XcKCcPif6KsrGwCzuxkCnN
         mkDbcAGpycmiyF/bMep7AL235d2bZeOSZlzT8hd4954o2QmDqeekOQc6zz8i1JDUqY1W
         zD+w==
X-Gm-Message-State: APjAAAWwF2mYel55RPOjUCGuT93eFq4JbfRY5fFObu/rZRfm8vFyf5uN
        WyV4VE8ZCANAFAthoe1mdl/vEXdJwefISvO+b8HsUQ==
X-Google-Smtp-Source: APXvYqwrBwar0BuKF5o1OAxMoU7hB62hCGOT7bVzjxmLgWUwoYSGq7w6IIfkKGw71lrHf/DcoAW/9/0VqOWM+hiU24A=
X-Received: by 2002:a67:f542:: with SMTP id z2mr5609156vsn.200.1559569744176;
 Mon, 03 Jun 2019 06:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190531113223.27474-1-colin.king@canonical.com>
In-Reply-To: <20190531113223.27474-1-colin.king@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 3 Jun 2019 15:48:27 +0200
Message-ID: <CAPDyKFpo6EqOp0mqVj7yHdttoh957QSZ8sFzHMs+QFz-cHETew@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: remove redundant check of slots == 0
To:     Colin King <colin.king@canonical.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 31 May 2019 at 13:32, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The calculation of slots results in a value in the range 1..8
> and so slots can never be zero.  The check for slots == 0 is
> always going to be false, hence it is redundant and can be
> removed.
>
> Addresses-Coverity: ("Logically dead code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index ab9e2b901094..f70436261746 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -2044,8 +2044,6 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
>
>         slots = PCI_SLOT_INFO_SLOTS(slots) + 1;
>         dev_dbg(&pdev->dev, "found %d slot(s)\n", slots);
> -       if (slots == 0)
> -               return -ENODEV;
>
>         BUG_ON(slots > MAX_SLOTS);
>
> --
> 2.20.1
>
