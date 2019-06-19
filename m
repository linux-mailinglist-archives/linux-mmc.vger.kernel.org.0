Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9CA4BA22
	for <lists+linux-mmc@lfdr.de>; Wed, 19 Jun 2019 15:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbfFSNjE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 19 Jun 2019 09:39:04 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37391 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFSNjE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Jun 2019 09:39:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id d11so12166980lfb.4
        for <linux-mmc@vger.kernel.org>; Wed, 19 Jun 2019 06:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QKggU93Ov3OGvJTHnvBvpp3+c/GovGceSumOJbG5Kag=;
        b=g90t1pfGMsBwZkO7WMEchWQcZ+/SFokkE8pEWUuLCb4C3gYFVxXCamqCaOHb0oU86f
         hKn1mrowaUHFrQhDAjQgFXxbg41JHSzq1WOEiWnerS2ucghntb6bKh1mc/92iTFACbbV
         ir2tYsqSxKSCptkKdrbEiwPCf9vRVMh1WzcZoJzreE9lvPIWSArEMNbxvXH55EY0eHMJ
         VCWVsBapJ5f1S4WGzeGFZvGIZYVs77NHAMs9895hD1WvrARdnQgxMzX8XwB7QkNTXyNw
         TOcsiylUCckRO1mfm2IvdhpoopFTotV8sg8FNECsAi3P4PrzuPz1rGptQlH9L7wHUg96
         QsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QKggU93Ov3OGvJTHnvBvpp3+c/GovGceSumOJbG5Kag=;
        b=dbml+zxt0I384A+jx0Q91Hzx7J5fpxoml6jhhzWBgBFMu+Q30VBuiwx2y7dvPnqsr1
         SOR7eT5uucOtQHX1/TyLpJeoOHYYcD5VSIl4lHXZZRkTlIEvxxuIqqEtDoWyhGBIV7ia
         /AhrflGCPowHUvOatBpSxMZsucRCvQz/1g9moWzS4+ZekkH/PcXggPBG6vQybjx5Q9j3
         9kt5i3SokvVnnJ2db5AEOxD4LsSuY6V49pT7msRGwGXh5Bd/W8wbUHC3p8NZZOmyMZoW
         9WZHxSBytn79jSCgSAx2VpwJkph6VF20/AISjm2HF9xEuQGW33aGO3+5fPrvN+7W8mN/
         9Z/w==
X-Gm-Message-State: APjAAAVf3U1Vq68fiKmeBSs+8zTVt34IulgEmscHKHeTSt4G6cuO8hOn
        sTqO9buFj7pHKEConQMx/zqHaQ==
X-Google-Smtp-Source: APXvYqzy1/85AoVZe5aXzHxGKPGMI3YKh1i1xTNcGjAlPkxkPNjoWmNiF/UkKqbk9mR2Jw4m3oq8iA==
X-Received: by 2002:a19:9156:: with SMTP id y22mr16577964lfj.43.1560951542029;
        Wed, 19 Jun 2019 06:39:02 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id c15sm3082664lja.79.2019.06.19.06.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 06:39:00 -0700 (PDT)
Date:   Wed, 19 Jun 2019 06:16:59 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, vincent.guittot@linaro.org,
        arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 9/9] arm64: dts: sprd: Add Spreadtrum SD host
 controller support
Message-ID: <20190619131659.vjw5kgepe6pz5inz@localhost>
References: <cover.1559635435.git.baolin.wang@linaro.org>
 <3ca273e341f2f5f66b121d411428c60afd412586.1559635435.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ca273e341f2f5f66b121d411428c60afd412586.1559635435.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jun 04, 2019 at 04:14:29PM +0800, Baolin Wang wrote:
> Add one Spreadtrum SD host controller to support eMMC card for Spreadtrum
> SC9860 platform.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Applied, thanks!


-Olof
