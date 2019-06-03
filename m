Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3295E3316E
	for <lists+linux-mmc@lfdr.de>; Mon,  3 Jun 2019 15:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfFCNsw (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 3 Jun 2019 09:48:52 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36711 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfFCNsw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Jun 2019 09:48:52 -0400
Received: by mail-vs1-f68.google.com with SMTP id l20so11275696vsp.3
        for <linux-mmc@vger.kernel.org>; Mon, 03 Jun 2019 06:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oOabyvE8wzavVfwd8vYkmNcYm1mrgFpt3KC1yUBwYIM=;
        b=xunThd3DuF5c0doe6up7dw7RyoPvzYQdwp4DlebjoaDzotYGIOP6YBpBZAy/Wl4/3h
         thdQ3GnBxH+6mjUGJmIBMArkWJgIk1GiwV/wynEpW1CLGnmycbm4IZQQDpnjh8a4cE95
         qnPazDgy/3ylDayIr4IsiaQE7cxIx1BKV6XNF7N1CYh4RhH6vX02jGinigcg4jp5H0vK
         g+Ge1I8Q+/6cHwn7Y+CjCrglnUyM5NOrjoI9iWZT1ontQuEOmO5XqknfyERSn5jU9LO1
         ZLgGHt/ZgdihIf/F9KMnZevGeyR2OlerQpjEDDgnbIcZD4c7VVZwuQ0F/YeSWks6YgTw
         jXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oOabyvE8wzavVfwd8vYkmNcYm1mrgFpt3KC1yUBwYIM=;
        b=DDGfp2LFFJa3vsWQQWsnDTfJvOPwypsT58d/3TSyAC4mcSTq0WNezT2haz/PxTJXYe
         gOZfDvqv3Cvq56Ytlg3hraoISnT6ACUwMn7gUfpNfAnlQEj2Gegr+2DwQlVfY6H3GQ0G
         3q3PXkzy3oRrR3a2AF76CMz2f97duf85Ltq0cMIhRr+zHeA4dvqGpPiZ7uSPrV1He+O/
         OWhqYmnmVH6uws/xOUnKsVewKY3YeI8Vf2F75brR4wLqGuquqZGXGuzASaNjqajp3sE+
         zlcN/ZbzEHoC4QFT3D1oqXwCVr1ghO6wtu/2J5LUmDACAgF5yqlJW/sjNkoKoIHP9D59
         wqhg==
X-Gm-Message-State: APjAAAU3F0MNNQyb9hReKe42DEHKfvOagzL7QH+d9ErZcDE7FeeEmMwE
        8D+y/ihrkhDXr1keEPzh9tus50cK/G0P39Dgq+tnHQ==
X-Google-Smtp-Source: APXvYqzEdPvWzQjjFpSHEuQm9FZr2NPQCyBaUvjtIxWRVkyS2WCtDm+HemdQFraj4sAa09wSbtwUDA6u+vbbyoDTdag=
X-Received: by 2002:a67:f485:: with SMTP id o5mr12809869vsn.165.1559569731068;
 Mon, 03 Jun 2019 06:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190528095928.26452-1-faiz_abbas@ti.com>
In-Reply-To: <20190528095928.26452-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 3 Jun 2019 15:48:14 +0200
Message-ID: <CAPDyKFr8LUqpdHGKDj2fK_XXHCSwJWS2=-G4EUhK3nqsDSeW+Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Fix issues with phy configurations in am65x MMC driver
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 28 May 2019 at 11:59, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> The following patches fix issues with phy configurations for
> sdhci_am654 driver.
>
> v3:
> Changed order of patches so that the first one can be applied easily to
> stable tree.
>
> v2:
> 1. Split patch 1 into 2 separate patches.
> 2. Improved patch descriptions.
>
> Faiz Abbas (3):
>   mmc: sdhci_am654: Fix SLOTTYPE write
>   mmc: sdhci_am654: Improve whitespace utilisation with regmap_*() calls
>   mmc: sdhci_am654: Print error message if the DLL fails to lock
>
>  drivers/mmc/host/sdhci_am654.c | 37 ++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
>

Patch 1 applied for fixes and by adding a fixes tag. Patch 2+3 applied
for next, thanks!

Kind regards
Uffe
