Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCCC4159537
	for <lists+linux-mmc@lfdr.de>; Tue, 11 Feb 2020 17:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgBKQmR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 11 Feb 2020 11:42:17 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36893 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgBKQmQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Feb 2020 11:42:16 -0500
Received: by mail-vs1-f68.google.com with SMTP id x18so6724880vsq.4
        for <linux-mmc@vger.kernel.org>; Tue, 11 Feb 2020 08:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KHkfZzNh1B4XmJZnXfgIQNWZsT5whG1kE8qQBYWXMgc=;
        b=WqyC94s0CD5d0ZPRr4dlQ93j+b50OoCaoHuxaKOKZ9lGE/26eG7Zpz10axDbzf5cxb
         agJY2MIEOmDQnmVeVxsWhCyJlffhvrtK79hVkzi4usTyPTyl3c9gdHucQAN6P9UAgoYx
         nArWP2wSBEJ1rS5b1O2lHsPS6x/yo/iTXctxezgmJsdLoyJlqvpWzge5pVPLcoU06f8E
         G6oLEE7mUeGdksmjfGbnMX+hoNNlbG4oxSYRlzwIb/R52rtvOPBSDc2MY48vpEV+dG97
         55ylTus7812YtsujzGDOnd4LmnifnC4HV86nRK0NaOuphuOpMPKW+5WOtR80XRx0/onh
         4xJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHkfZzNh1B4XmJZnXfgIQNWZsT5whG1kE8qQBYWXMgc=;
        b=tP+bFBvvhPAulcGYKD2PYlIeKTNhSV453Atk4IVNsamFB5xqum4taNyo+L8s5WGV3w
         hRuUxNMzxcozjXtdXJadbpQxN7UtPUXivzYWw0QL+Y/u8P01rb2LwPlG0X+bIBYkRUAb
         yw+DGF1AIj0CE1RrNsMzz5ECXvFJSmu36tM2Mj2w5M4QY6wN7u+SEwW0VfAYH+PiwEO8
         +A3CGbj6q+aWaV7HgbVFNB4/InS1DbrMsxcp5hax1BAzFi5Tp/aePl/DmFVeRN170f57
         GQSX/AmQQJrGqgbi7xGBTvd/11srzpA/wZL4tW9+U4ae7XVJeBoIXdM7CZxvF+wkfgwq
         N6Xw==
X-Gm-Message-State: APjAAAVnbJ5rGcNStHYZeRGAIophLTi8myHCJc9fIcPJNY5rRD0FnXu9
        rLqcMit1fqjhMzwJcf5Pgp9l2E34lMVVQrNRgpGOaA==
X-Google-Smtp-Source: APXvYqxqMq+ejXxPsl9/xIf55OXMeWrD7wxRfObKKoy3oMAN0UARPc8I0EQfK/M1BGYcb9ZuENsUbz+LrH8gmb00USk=
X-Received: by 2002:a67:fa1a:: with SMTP id i26mr9638813vsq.169.1581439335360;
 Tue, 11 Feb 2020 08:42:15 -0800 (PST)
MIME-Version: 1.0
References: <1581434955-11087-1-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1581434955-11087-1-git-send-email-vbadigan@codeaurora.org>
From:   Doug Anderson <dianders@google.com>
Date:   Tue, 11 Feb 2020 08:42:01 -0800
Message-ID: <CAD=FV=X6-aWM_fSfLE0ySuM04FvQCTKpM-A87k3xMXBMRzNXFQ@mail.gmail.com>
Subject: Re: [PATCH V1] dt-bindings: mmc: sdhci-msm: Add CQE reg map
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>, cang@codeaurora.org,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Tue, Feb 11, 2020 at 7:29 AM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> CQE feature has been enabled on sdhci-msm. Add CQE reg map
> that needs to be supplied for supporting CQE feature.
>
> Change-Id: I788c4bd5b7cbca16bc1030a410cc5550ed7204e1
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 7ee639b..eaa0998 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -27,6 +27,11 @@ Required properties:
>  - reg: Base address and length of the register in the following order:
>         - Host controller register map (required)
>         - SD Core register map (required for msm-v4 and below)
> +       - CQE register map (Optional, needed only for eMMC and msm-v4.2 above)

I did a quick search and it appears that SD cards implementing 6.0 of
the spec can also use CQE.  Is that correct?  If so, maybe remove the
part about "eMMC"?

Maybe also change "needed" to "useful" to make it clear that this
entry isn't actually required for all msm-v4.2 controllers?


> +- reg-names: When CQE register map is supplied, below reg-names are required
> +       - "hc_mem" for Host controller register map
> +       - "core_mem" for SD cpre regoster map

s/regoster/register


> +       - "cqhci_mem" for CQE register map

I'm at least slightly confused.  You say that reg-names are there only
if CQE register map is supplied.  ...and that requires 4.2 and above.
...but "core_mem" is only there on 4.0 and below.  So there should
never be a "core_mem" entry?

Trying to specify that sanely in free-form text seems like it's gonna
be hard and not worth it.  You should probably transition to yaml
first?


I will also note that Rob isn't a huge fan of "reg-names".  In a
different conversation I think you mentioned you had a reason for
having it.  I guess just be prepared to defend yourself against Rob if
you feel strongly about keeping reg-names.


-Doug
