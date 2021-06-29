Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B158B3B74DA
	for <lists+linux-mmc@lfdr.de>; Tue, 29 Jun 2021 17:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbhF2PL5 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 29 Jun 2021 11:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhF2PL4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jun 2021 11:11:56 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1D5C061760
        for <linux-mmc@vger.kernel.org>; Tue, 29 Jun 2021 08:09:28 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id x12so12306065vsp.4
        for <linux-mmc@vger.kernel.org>; Tue, 29 Jun 2021 08:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWyRLBBzgf82zmSwYmpQjeYYSxE8nuOtzS0SYPYQZes=;
        b=JtjjYJbTEx+NAYAOQIsFdxj7A+fFEvkJVSQSBs2P0ltlBtcbq19Qu1tN7rgQ+KDK63
         CmrLMTyhgsp65Mxn+dFQBeMENsgjb8XN+8N0WqTcj3rj086n2tauOXLG4JeogJQ9WXOT
         a+WfK+Oo4uchEdLIHAgTUtRaNAJDzVWqCAdt81Vhg9WXvAsIG5OiLv3uvQHfNLGnUyr4
         nfQKUeaquuTzvI0VH3k22DOs/BNFXWb+mj6fpdzlyegVUSjVbgRp99Wm+DDGzqNl8as7
         /bcZAlZYPpu9BgKgA+ps/qfAwRBWKnxn1iJiFK6ZXG4OYMO102dIvo1oFoug/FGGokAw
         n4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWyRLBBzgf82zmSwYmpQjeYYSxE8nuOtzS0SYPYQZes=;
        b=rYvbVlcM/UGxMlRBRPJKU0Qa/f7c3b7aYM3dES+NAUoG5qPRKaspj//r9zjS5502fU
         xtfvgD1QIrafwflN+uHYVna3iH73itLuuhtAGE21q6zE/XZlUAZO1QkleKQSx+6sAbG8
         exQir74ksXsNb3z/S0Y5J9Drs4NaZ/QCbYBK0C37WWBG2BQm6bjCrIW4eFeygah7zVY+
         UWjGeQ9+FprQe57iw4L7kWpn6sKRDNHI2PwqcwFi7f5WNeivKAmKSNcXII4ZixfQ7ppK
         1Ty6vYgLl7p4wXSHf6kjdLMl9GRf97FK0ZXk65qsTpQNFzvlKtEB9Xtfj0i/rI6llDIY
         hQQA==
X-Gm-Message-State: AOAM5335Vh8QNWQChH58qP48o5zSI2u2u2QmDtY6m8pf6OY3HvWnZ1XG
        05xdCRLJEfD/dh0Jb9jmWBob3PdM7fcl878f8REKHg==
X-Google-Smtp-Source: ABdhPJyogwnB5cFpynG2uMlaowGmYRosZMAQ0iWDWGyyH4iDyJ5iB+6sJfrM4q6alnjUaP5QDA+GBWxi8e8w9ERls30=
X-Received: by 2002:a05:6102:502:: with SMTP id l2mr25383417vsa.19.1624979367699;
 Tue, 29 Jun 2021 08:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210624151616.38770-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20210624151616.38770-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Jun 2021 17:08:51 +0200
Message-ID: <CAPDyKFo7C8ZaGm3QeeOUjFjxzYM7Rf89FZMrO9dxCYkzJ6gEbg@mail.gmail.com>
Subject: Re: [PATCH 0/3] mmc: avoid vicious circle when retuning
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 24 Jun 2021 at 17:16, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> See patch 1 for a description of the problem. This series implements the
> alternative approach suggested by Adrian (thanks!). It also adds some
> documentation and a minor cleanup which I came up with while working on
> the fix. Patch 1 can go to stable as is, the rest built on top of that.
>
> This series fixes the performance issue which we saw when injecting CRC
> errors on Renesas R-Car Gen3 hardware.
>
> Looking forward to comments!
>
>
> Wolfram Sang (3):
>   mmc: core: clear flags before allowing to retune
>   mmc: host: add kdoc for mmc_retune_{en|dis}able
>   mmc: host: factor out clearing the retune state
>
>  drivers/mmc/core/core.c |  6 ++++--
>  drivers/mmc/core/host.c | 13 +++++++++++--
>  drivers/mmc/core/host.h |  6 ++++++
>  3 files changed, 21 insertions(+), 4 deletions(-)
>
> --
> 2.30.2
>

Patch1 applied for fixes and by adding a fixes+stable tag. Patch2 and
patch3, queued up for v5.15 (temporary on the devel branch).

Thanks and kind regards
Uffe
