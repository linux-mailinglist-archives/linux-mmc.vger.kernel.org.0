Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BF72A4C30
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Nov 2020 18:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgKCRDL (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 3 Nov 2020 12:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgKCRDL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Nov 2020 12:03:11 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167E0C0617A6
        for <linux-mmc@vger.kernel.org>; Tue,  3 Nov 2020 09:03:11 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id f38so14162184pgm.2
        for <linux-mmc@vger.kernel.org>; Tue, 03 Nov 2020 09:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=D1Yz0PdKp2fAxKQgHZ9fvVHAcVDky1zVOyGTbKX5Auc=;
        b=tzUziYaBmFecN8fN34P0eMETy51o+ZYvS6swXkYhfneR6oUDxnW7nrxBJKId4/0Dfe
         Lq500xXGfs9u5rgvrOgwrOVcHv8+OFmkRS4A/m02FaPKNYwiMvBfPtlvns1eBoEvw7Q3
         KMfVBGb9vcX0PrbpLbJwwq+rY1bYTt+9Nrq8xNCgQ6qwqESbTLpgoQQjJA1pksrhQA6f
         UkM9LZi73No/JNnvbfv4gj61eh7LtQo/C7ZoYu2zWbuKSkw3BudsFNYaISwk8qV3W/Ti
         VAcxBGoUd9a11h5de0Z+RCn0wdPF3sRZTXLVWcNhJUcHCZj9a9t3pUsEhgShC8/YHXXR
         xuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=D1Yz0PdKp2fAxKQgHZ9fvVHAcVDky1zVOyGTbKX5Auc=;
        b=gzF7DkIAxx4kGXxZiSn847VvoU+Gxsyj8DkODITuyxAY7nwZx6yThrufjJxDrKJlOj
         SvWiD1wqjTz//VgHrFXb4O1kBFgMTkQ79SbHxXyqPDYpYMhLJpi8WDBbTl214egHZtc6
         wAqjLw9U2l5RS5zJytJoq0KGF+u9BUL+1HUJtghOalBpCmyR0+lNLt4XPILFKNO8RqF7
         j2KP+qnSHS6LgZIpx8BGfKba04X5UKbrIsifwtsb2wmf2tsND5GAv+BSIrtmQUB5jkzv
         jgf1EiNalpf3ALdL6FWQDpe3devu409GAk7N3ENd+agdmUjR4mEUhe7TZ3xvyYA7sG33
         c4TQ==
X-Gm-Message-State: AOAM532I3+uxwMNlF8zqd4QOj2GT2ZvtrMCbnHecQxlX0Zgdee0nYDp1
        R1/RD49UgxIutidgq/Y3tdNJmA==
X-Google-Smtp-Source: ABdhPJxQDRCrDmfUzdH7nNuHf3LOYUtDlNVoRljtLRDfYLGKoA3QTBfon/AVTo6kqD0R/tmx5wk7Iw==
X-Received: by 2002:a17:90a:5892:: with SMTP id j18mr88245pji.101.1604422990409;
        Tue, 03 Nov 2020 09:03:10 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id b17sm15775682pgb.94.2020.11.03.09.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 09:03:08 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mmc: meson-gx: drop of_match_ptr from of_device_id table
In-Reply-To: <20201103163046.14336-1-krzk@kernel.org>
References: <20201103163046.14336-1-krzk@kernel.org>
Date:   Tue, 03 Nov 2020 09:03:08 -0800
Message-ID: <7h4km6xtir.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Krzysztof Kozlowski <krzk@kernel.org> writes:

> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant here).  This fixes
> compile warning (!CONFIG_OF && !CONFIG_MODULES):
>
>     drivers/mmc/host/meson-gx-mmc.c:1252:34: warning:
>         =E2=80=98meson_mmc_of_match=E2=80=99 defined but not used [-Wunus=
ed-const-variable=3D]
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks for the fix.

Acked-by: Kevin Hilman <khilman@baylibre.com>

Kevin
