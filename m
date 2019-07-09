Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E71B63D5E
	for <lists+linux-mmc@lfdr.de>; Tue,  9 Jul 2019 23:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfGIVbr (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 9 Jul 2019 17:31:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43537 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGIVbr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jul 2019 17:31:47 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so118892ios.10
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jul 2019 14:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m+Q6OKHB4bjuA+HKRJoJXplccc4Q4BX/DPB0CSkNBfg=;
        b=jXXNF60XQ/xWIVsNNbZL3eDl1iyRkV2wUimvy/t5P4f2Y9AdAj79hrbkiF4p2XToXh
         PjlMOcdLlv3NklnZFKzraxechJEVrnBSZKUw8/khqATqOYB/uk7uPs4JLCvALCZH+iyO
         tL2y3uBGNmr5ik3mE9cxdMzErpUncIvQQBR0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m+Q6OKHB4bjuA+HKRJoJXplccc4Q4BX/DPB0CSkNBfg=;
        b=HvRxqOM+PfKYxqkvjoWlx9knFQljClLlZQHF8VgZtveG3K1EYKsHXW5Ifm3ExDDve6
         P7b2nAt+mFLVhJxrzbxRq+AXZYXlBZ13KSrCrLRLSY8wlrt+KdIhbhzI5PEeoyEd5KIk
         TdI3QD0hCClZX60WVMNhnLSS8l5e7ctLoPkmZXh3BX86FuI9gRo/WQGZSyfBIktt6344
         Hp83+joWR9opERDnaAVTRIZmabXyG93sFRigdhFGVVTFyaJvwFh1TVyF+n+SMNCzPFw9
         IRDpyojndxeUcBuKX81cdn56ksNQJMbznddjXCBApaPU5+y3jrD6cn6uiTMRc4TFWDFA
         J3ng==
X-Gm-Message-State: APjAAAVuEv8LMXrbviNwezlpwV0GcHMvTdZ0YEtWat/JQdil01EqtnPI
        bZvSHjmRPeFiUtrsCQxUZYeB9silGTY=
X-Google-Smtp-Source: APXvYqzaIKp/8IcelcHcMD5XwpcxVp8gTChCD3aQurgkgYodBFe7m6go3M+caSaR0sWZhRY+3mmebA==
X-Received: by 2002:a05:6638:40c:: with SMTP id q12mr31706226jap.17.1562707906096;
        Tue, 09 Jul 2019 14:31:46 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id j5sm17480835iom.69.2019.07.09.14.31.45
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 14:31:45 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id q22so185760iog.4
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jul 2019 14:31:45 -0700 (PDT)
X-Received: by 2002:a5e:db0a:: with SMTP id q10mr7438751iop.168.1562707904855;
 Tue, 09 Jul 2019 14:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190618153448.27145-1-ulf.hansson@linaro.org> <20190618153448.27145-8-ulf.hansson@linaro.org>
In-Reply-To: <20190618153448.27145-8-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 9 Jul 2019 14:31:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VdECYQCLAFd+J6xYBXSJVLMb5_iGs+DYCmeDbW0N-SOQ@mail.gmail.com>
Message-ID: <CAD=FV=VdECYQCLAFd+J6xYBXSJVLMb5_iGs+DYCmeDbW0N-SOQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] mmc: sdio: Drop unused in-parameter from mmc_sdio_init_card()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Tue, Jun 18, 2019 at 8:35 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The "powered_resume" in-parameter to mmc_sdio_init_card() has now become
> redundant as all callers set it to 0. Therefore let's just drop it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
