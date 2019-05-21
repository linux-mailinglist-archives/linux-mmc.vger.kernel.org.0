Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE37258AE
	for <lists+linux-mmc@lfdr.de>; Tue, 21 May 2019 22:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfEUUMj (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 21 May 2019 16:12:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36432 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbfEUUMj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 May 2019 16:12:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id a3so65279pgb.3
        for <linux-mmc@vger.kernel.org>; Tue, 21 May 2019 13:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=nSMrBlQQCNOdHw6ym1MsOYq9Zt6fXAndfJkhXIkeTfY=;
        b=UKYH7WLV2ulLB4lxqEK1p6vKzcO/oYH0HKk0Uf1ngLMKlUIdsEZBeUP2RkJFviqTla
         /+Kpld/0OVy8Fuu4qrbvy5/us03iBvFcqM+dVkzCFWvmn1i4828WYorclEAU+0cKoB52
         qGBBHkjShpmLqeb/cdWbB2QEVLwISsfCNYX2LIybY7DgaXWrQ0lAqmRkpz8nqcAd/xcQ
         OjuH+kA3zAJwDCA79zLs2+71YrQzyveKWqS74wE5wEE4E+MrnQY4xFcQpWoRP1bbJdyB
         m9wKLfHxAUaCWwuXGeFGpkWoWgfmGxwC1oPGoROkVjiJk1u2GLFaFOWidJ4WiwFzUsGl
         CaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nSMrBlQQCNOdHw6ym1MsOYq9Zt6fXAndfJkhXIkeTfY=;
        b=exels2HI1dajMSMBASO+wuQBvVrqxUM5XisC2Qkb3D7CAY7xy1T4RKPTdlVw/Cn21y
         efEYLNvi8hVk4kYFzudKuOpuaxlX80NhorPc62tfewCzR7JJkleTjtQTVQHl2Tb6I3ro
         oXXxGP5kW5JoDjvQD6oA/+AbkqE9eN8QCV4bt7hJWODrvRb4u4a0Rgf/2Ewj9j6bWrGa
         zDGJZllnF/o/IvMCAGIkkU/y5oFo/6dxYGWj8TzVl/zhEkEdmSq68uEjy0TfOb77lRqW
         fbZ93fw2UMKpBIIFbKTDbN/Q6C/LXLbk+F5QwSSv5dhBSlZlNC4RMICb/jQu03j383JK
         yy5A==
X-Gm-Message-State: APjAAAU8SpKbUBVXAYaoYhkTX+KtTxj0PoLCR4lbFpt5vFujlBIOli10
        7z54wXBE2mYRr6Pi52EAbpJKyA==
X-Google-Smtp-Source: APXvYqxVEPOLzIUAcEnvDwqtTQaoCBe/SQRAw+I1ByMAhdJAZkI38UAVWTgq+qFcuMrL99a0Mwl45A==
X-Received: by 2002:a62:4d03:: with SMTP id a3mr92113713pfb.2.1558469558426;
        Tue, 21 May 2019 13:12:38 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:b1ca:3800:3284:d770])
        by smtp.googlemail.com with ESMTPSA id r138sm29927872pfr.2.2019.05.21.13.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 13:12:37 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, ulf.hansson@linaro.org
Cc:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] mmc: meson-gx-mmc: update with SPDX Licence identifier
In-Reply-To: <20190520143647.2503-2-narmstrong@baylibre.com>
References: <20190520143647.2503-1-narmstrong@baylibre.com> <20190520143647.2503-2-narmstrong@baylibre.com>
Date:   Tue, 21 May 2019 13:12:37 -0700
Message-ID: <7h5zq37eiy.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
