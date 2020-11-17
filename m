Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01252B5EA5
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Nov 2020 12:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgKQLuk (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Nov 2020 06:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgKQLuj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Nov 2020 06:50:39 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548CCC0613CF
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:50:39 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id u7so10860465vsq.11
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QdGMrmypiTSDWHZZMs3XLE4NKMgt+eR1oHTkBUjiKl0=;
        b=pwfQAwZ2hnguHi2wPV3s4+aqsc7BjT7SqkKC6nxg1tRrhLnOVK6dgUkccy0VBnWunI
         P++v/caejkQiON6I19FwHaqTCjeY58t+W7w9o5F7YlSbBgv2l7SFgOlkdDBVjUqWy8xt
         JnTikUh4TlPfAGujZVsr0R3w3/JHSAC1TmOZ3h2sGOSQPTbCNoucNVb8K3JQSylN99w3
         CdHzbgArIhUO+K/HFTFIEUa3CEDWZY299G1EQdci6qVgkdpWUv1r4j3K/XOhthrO0hFi
         fa2xPmPKxvG4UFLI1+3oO2jU3005qbUpbqUQOxGSySmHceFLCHsSQbX5NNOhcCcDjzRV
         DndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QdGMrmypiTSDWHZZMs3XLE4NKMgt+eR1oHTkBUjiKl0=;
        b=R/q/fGfT+A/Czp9gaYUSNcTA9RsaibCv8wjqjjzfYQEMT568RnKZb9nHgHd1rGB9Tg
         aGWYwnSHkxnMbzWIerWpJdRwHAm4LG2B+ef85tq9CYtoIBFy+VqJSLPaUAO0wxdFmvRZ
         BcgnYbTsUrB1pACZl0sCoE6rzzIp+ULulo65hCvFR5sZmJoHvySB89QuDyg1KwuDFkRJ
         pvsqUWm63cZo5VtNn3SpDevXrdeHkOcAjBxXKF+ZtUfwScd4ouFYhcrWTESiRZ2p2hIr
         3l35s5L1ADXLVzxqVg3JwZnZ077q91/7dDZPl9rXsA23BOIRBsY9rPdwGuC43On6wGvy
         ou1A==
X-Gm-Message-State: AOAM5337KUt3pkoFsDsqywIJMzIAwUrUMyXD78gpFWnRFICKDlT14zIx
        K10SMoAxGWw0t6qv6iWaJ8qPW9I0B8zaIBbaFDg0yw==
X-Google-Smtp-Source: ABdhPJx3gsjDIZ/HDtQJ0bDeqrR9TAcFyU7xq3Egmki5etJ8inBw3XJVCv4q8wXI03vEyu0ddK2wmbDuNUEv+OaOfrw=
X-Received: by 2002:a67:f417:: with SMTP id p23mr10800328vsn.42.1605613838608;
 Tue, 17 Nov 2020 03:50:38 -0800 (PST)
MIME-Version: 1.0
References: <20201111100244.15823-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20201111100244.15823-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Nov 2020 12:50:02 +0100
Message-ID: <CAPDyKFqKK1H_XTBx+13cLNOq_A_5Nr7F3bHnxqYGnYOESvJV+w@mail.gmail.com>
Subject: Re: [PATCH 0/3] mmc: renesas_sdhi: generic cleanups
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 11 Nov 2020 at 11:02, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Here are a few patches fixing cosmetic issues which always annoyed me
> when working on this driver. Patches #1+#2 improve naming and remove
> hardcoded values. Patch #3 sorts the defines. The object files were
> identical here before and after the patchset, as expected.
>
> The patches depend on the series "[PATCH 0/3] mmc: renesas_sdhi:
> refactor SCC reset" and are part of this branch:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/tap_en_v2
>
> Hope you'll like it,
>
>    Wolfram
>
>
> Wolfram Sang (3):
>   mmc: renesas_sdhi: improve HOST_MODE usage
>   mmc: renesas_sdhi: don't hardcode SDIF values
>   mmc: renesas_sdhi: sort includes
>
>  drivers/mmc/host/renesas_sdhi_core.c | 49 +++++++++++++++++-----------
>  drivers/mmc/host/tmio_mmc.h          |  1 -
>  2 files changed, 30 insertions(+), 20 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
